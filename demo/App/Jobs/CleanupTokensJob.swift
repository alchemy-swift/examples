import Alchemy

struct CleanupTokensJob: Job, Codable {
    func handle(context: Context) async throws {
        let ninetyDaysAgo = Date().addingTimeInterval(-60 * 60 * 24 * 90)
        try await UserToken.delete("created_at" < ninetyDaysAgo)
    }
}
