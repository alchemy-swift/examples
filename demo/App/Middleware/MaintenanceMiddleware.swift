import Alchemy

struct MaintenanceMiddleware: Middleware {
    func handle(_ request: Request, next: Next) async throws -> Response {
        if Env.MAINTENANCE_ACTIVE ?? false {
            throw HTTPError(.serviceUnavailable)
        }

        return try await next(request)
    }
}
