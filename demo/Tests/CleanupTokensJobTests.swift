@testable import App
import AlchemyTest

final class CleanupTokensJobTests: TestCase<App> {
    override func setUp() async throws {
        try await super.setUp()

        // Migrate the test database.
        try await DB.migrate()

        // Seed the database with 3 tokens.
        try await UserToken.seed(3)

        // Update one of the tokens to be expired.
        try await UserToken.random()?.update(["created_at": Date.distantPast])
    }

    func testCleanup() async throws {
        try await AssertEqual(UserToken.count(), 3)
        try await CleanupTokensJob().handle()
        try await AssertEqual(UserToken.count(), 2)
    }
}
