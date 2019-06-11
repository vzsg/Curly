import Vapor

public class CurlyProvider: Provider {
    public init() {
    }
    
    public func register(_ services: inout Services) throws {
        services.register(CurlyClient.self)
        services.register { _ in CurlyOptionStorage() }
    }
    
    public func didBoot(_ container: Container) throws -> EventLoopFuture<Void> {
        return container.future()
    }
}
