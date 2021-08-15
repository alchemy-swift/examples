import Alchemy

extension App {
    /// Configure the application's job queues.
    func queue() {
        Queue.config(default: .redis())
        Queue.config("database", .database(.named("mysql")))
        
        registerJob(CleanupTokens.self)
    }
}
