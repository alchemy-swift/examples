import Alchemy

public struct App: Application {
    public init() {}
    
    /// Boot the application.
    public func boot() {
        database()
        redis()
        queue()
        router()
        scheduler()
    }
}
