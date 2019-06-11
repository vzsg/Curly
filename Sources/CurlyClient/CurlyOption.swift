import Vapor

public enum CurlyOption {
    case proxy(String)
    case proxyAuth(user: String, password: String)
    case timeout(seconds: Int)
    case connectTimeout(seconds: Int)
    case cookieJar(String)
    case followRedirects(Bool)
    case insecure(Bool)
}

extension Request {
    public func addCurlyOption(_ option: CurlyOption, file: StaticString = #file, line: Int = #line) {
        guard let storage = storage else {
            let warning = "[\(file):\(line)] Request.addCurlyOption was called without registering CurlyProvider!"
            
            #if DEBUG
            fatalError(warning)
            #else
            print(warning)
            return
            #endif
        }
        
        storage.options.append(option)
    }
}
