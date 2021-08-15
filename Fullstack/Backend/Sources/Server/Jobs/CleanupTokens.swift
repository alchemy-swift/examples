import Alchemy

struct CleanupTokens: Job {
    /// Run this Job.
    func run() -> EventLoopFuture<Void> {
        let ninetyDaysAgo = Date().addingTimeInterval(-60 * 60 * 24 * 90)
        return UserToken.where("created_at" < ninetyDaysAgo)
            .delete()
            .voided()
    }
}
