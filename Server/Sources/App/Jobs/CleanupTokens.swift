import Alchemy

struct CleanupTokens: Job {
    
    /// Run this Job.
    func run() async throws {
        let ninetyDaysAgo = Date().addingTimeInterval(-60 * 60 * 24 * 90)
        try await UserToken.delete("created_at" < ninetyDaysAgo)
    }
}
