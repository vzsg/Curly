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
        case .timeout(let seconds):
            return [.timeout(seconds)]
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
        }
    }
}
