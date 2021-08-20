import Alchemy

@main
struct App: Application {
    /// Boot the application.
    func boot() {
        database()
        redis()
        queue()
        router()
        scheduler()
    }
}
