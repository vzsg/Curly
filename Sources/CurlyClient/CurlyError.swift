import CCurlyCURL

public struct CurlyError: Error {
    public let code: CURLErrorCode
    public let description: String
    
    init(_ response: CURLResponse, code: CURLcode) {
        self.code = CURLErrorCode.from(code)
        self.description = response.curl.strError(code: code)
    }
}
