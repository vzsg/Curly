import Vapor

public final class CurlyClient: Client, ServiceType {
    public var container: Container
    
    public static var serviceSupports: [Any.Type] {
        return [Client.self]
    }
    
    public static func makeService(for worker: Container) throws -> CurlyClient {
        return .default(on: worker)
    }
    
    public static func `default`(on container: Container) -> CurlyClient {
        return .init(on: container)
    }
    
    public init(on container: Container) {
        self.container = container
    }
    
    public func send(_ req: Request) -> EventLoopFuture<Response> {
        let promise = container.eventLoop.newPromise(Response.self)
        
        CURLRequest(req: req)
            .perform { comp in
                do {
                    let response = try comp()
                    promise.succeed(result: Response(curl: response, on: req))
                } catch {
                    promise.fail(error: error)
                }
        }
        
        return promise.futureResult
    }
}

private extension CURLRequest {
    convenience init(req: Request) {
        let http = req.http
        self.init(http.urlString)
        
        self.options.append(.httpMethod(.from(string: "\(http.method)")))
        
        if let data = http.body.data, !data.isEmpty {
            self.options.append(.postData(Array(data)))
        }
        
        http.headers.forEach { key, val in
            self.addHeader(.fromStandard(name: key), value: val)
            return
        }
        
        if let storage = req.storage {
            storage.options.forEach {
                $0.curlOption.forEach { self.options.append($0) }
            }
        }
    }
}

private extension Response {
    convenience init(curl: CURLResponse, on container: Container) {
        var http = HTTPResponse()
        
        http.status = HTTPResponseStatus(statusCode: curl.responseCode)
        http.body = HTTPBody(data: Data(curl.bodyBytes))
        
        curl.headers.forEach { key, value in
            http.headers.replaceOrAdd(name: key.standardName, value: value)
        }
        
        self.init(http: http, using: container)
    }
}
