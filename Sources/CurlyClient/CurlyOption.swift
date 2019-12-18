import Vapor

public enum CurlyOption {
    /// Proxy server address.
    case proxy(String)
    /// Proxy server username/password combination.
    case proxyAuth(user: String, password: String)
    /// Port override for the proxy server.
    case proxyPort(Int)
    /// Maximum time in seconds for the request to complete.
    /// The default timeout is never.
    case timeout(Int)
    /// Maximum time in milliseconds for the request to complete.
    /// The default timeout is never.
    case timeoutMs(Int)
    /// Maximum time in seconds for the request connection phase.
    /// The default timeout is 300 seconds.
    case connectTimeout(Int)
    /// Maximum time in milliseconds for the request connection phase.
    /// The default timeout is 300 seconds.
    case connectTimeoutMs(Int)
    /// The name of the file from which cookies will be read before,
    /// and written to after performing the HTTP request.
    case cookieJar(String)
    /// Indicates that the request should follow redirects. Default is false.
    case followRedirects(Bool)

    /// Indicates whether the request should skip verification of the authenticity of the peer's certificate. Defaults to false.
    /// Deprecated, use .sslVerifyPeer(false) instead.
    @available(*, deprecated, message: "Use the sslVerifyPeer and other SSL options instead.")
    case insecure(Bool)

    /// Indicates whether the request should verify the authenticity of the peer's certificate. Defaults to true.
    case sslVerifyPeer(Bool)
    /// Indicates whether the request should verify that the server cert is for the hostname of the server. Defaults to true.
    case sslVerifyHost(Bool)
    /// Path, optional type (defaults to PEM) and optional passphrase (defaults to none) for a client private key file.
    case sslKey(path: String, type: CurlySSLFileType?, password: String?)
    /// Path and optional type (defaults to PEM) for a client certificate.
    case sslCert(path: String, type: CurlySSLFileType?)
    /// Path to file holding one or more certificates which will be used to verify the peer.
    case sslCAFilePath(String)
    /// Path to directory holding one or more certificates which will be used to verify the peer.
    case sslCADirPath(String)
    /// Override the list of ciphers to use for the SSL connection.
    /// Consists of one or more cipher strings separated by colons. Commas or spaces are also acceptable
    /// separators but colons are normally used. "!", "-" and "+" can be used as operators.
    case sslCiphers([String])
    /// File path to the pinned key.
    /// When negotiating a TLS or SSL connection, the server sends a certificate indicating its
    /// identity. A key is extracted from this certificate and if it does not exactly
    /// match the key provided to this option, curl will abort the connection before
    /// sending or receiving any data.
    case sslPinnedPublicKey(String)
}

public enum CurlySSLFileType {
    case pem, der, p12, eng
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
