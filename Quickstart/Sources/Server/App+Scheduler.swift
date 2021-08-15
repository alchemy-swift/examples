import Alchemy

extension App {
    /// Configure the application's scheduled tasks & jobs.
    func scheduler() {
        schedule(job: CleanupTokens()).daily()
        
        schedule { Log.info("Happy Friday!") }
            .weekly(day: .fri, hour: 9)
    }
}
