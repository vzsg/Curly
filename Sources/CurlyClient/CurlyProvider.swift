import Vapor

public class CurlyProvider: Provider {
    private let globalOptions: [CurlyOption]

    public init(globalOptions: [CurlyOption] = []) {
        self.globalOptions = globalOptions
    }
    
    public func register(_ services: inout Services) throws {
        services.register(CurlyClient.self)
        services.register { [globalOptions] _ in CurlyOptionStorage(options: globalOptions) }
    }
    
    public func didBoot(_ container: Container) throws -> EventLoopFuture<Void> {
        return container.future()
    }
}
