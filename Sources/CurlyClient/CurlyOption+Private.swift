import Vapor

class CurlyOptionStorage: Service {
    var options: [CurlyOption] = []
}

extension Request {
    var storage: CurlyOptionStorage? {
        get {
            return try? privateContainer.make(CurlyOptionStorage.self)
        }
    }
}

extension CurlyOption {
    var curlOption: [CURLRequest.Option] {
        switch self {
        case .connectTimeout(let seconds):
            return [.connectTimeout(seconds)]
        case .connectTimeoutMs(let ms):
            return [.connectTimeoutMs(ms)]
        case .timeout(let seconds):
            return [.timeout(seconds)]
        case .timeoutMs(let ms):
            return [.timeoutMs(ms)]
        case .cookieJar(let file):
            return [.cookieFile(file), .cookieJar(file)]
        case .proxy(let proxy):
            return [.proxy(proxy)]
        case .proxyAuth(let user, let password):
            return [.proxyUserPwd("\(user):\(password)")]
        case .followRedirects(let follow):
            return [.followLocation(follow)]
        case .insecure(let insecure):
            return [CURLRequest.Option.sslVerifyPeer(!insecure)]
        case .proxyPort(let port):
            return [.proxyPort(port)]
        case .sslVerifyPeer(let verify):
            return [.sslVerifyPeer(verify)]
        case .sslVerifyHost(let verify):
            return [.sslVerifyHost(verify)]
        case .sslKey(let path, let type, let password):
            var options: [CURLRequest.Option] = [.sslKey(path)]

            if let type = type {
                options.append(.sslKeyType(type.curlType))
            }

            if let password = password {
                options.append(.sslKeyPwd(password))
            }

            return options
        case .sslCert(let path, let type):
            var options: [CURLRequest.Option] = [.sslCert(path)]

            if let type = type {
                options.append(.sslCertType(type.curlType))
            }

            return options
        case .sslCAFilePath(let path):
            return [.sslCAFilePath(path)]
        case .sslCADirPath(let path):
            return [.sslCADirPath(path)]
        case .sslCiphers(let ciphers):
            return [.sslCiphers(ciphers)]
        case .sslPinnedPublicKey(let key):
            return [.sslPinnedPublicKey(key)]
        }
    }
}

private extension CurlySSLFileType {
    var curlType: CURLRequest.SSLFileType {
        switch self {
        case .der:
            return .der
        case .eng:
            return .eng
        case .p12:
            return .p12
        case .pem:
            return .pem
        }
    }
}
