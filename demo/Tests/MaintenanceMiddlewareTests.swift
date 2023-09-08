@testable import App
import AlchemyTest

final class MaintenanceMiddlewareTests: TestCase<App> {
    func testMaintenanceMiddlewareInactive() async throws {
        try await Test.get("/user").assertUnauthorized()
        Environment.fake(values: ["MAINTENANCE_ACTIVE": "false"])
        try await Test.get("/user").assertUnauthorized()
    }

    func testMaintenanceMiddlewareActive() async throws {
        Environment.fake(values: ["MAINTENANCE_ACTIVE": "true"])
        try await Test.get("/user").assertStatus(.serviceUnavailable)
    }
}
