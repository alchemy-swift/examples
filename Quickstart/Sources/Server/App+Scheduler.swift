import Alchemy

extension App {
    /// Use this function to configure the application's scheduled tasks & jobs.
    func scheduler() {
        schedule(job: CleanupTokens()).daily()
        
        schedule { Log.info("Happy Friday!") }
            .weekly(day: .fri, hour: 9)
    }
}
