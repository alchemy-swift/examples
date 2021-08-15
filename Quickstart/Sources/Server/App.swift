import Alchemy

@main
struct App: Application {
    /// Boot the application.
    func boot() {
        database()
        queue()
        redis()
        router()
        scheduler()
    }
}
