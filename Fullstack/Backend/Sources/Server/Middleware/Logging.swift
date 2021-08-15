import Alchemy

struct LoggingMiddleware: Middleware {
    /// Intercept a requst, returning a future with a Response
    /// representing the result of the subsequent handlers.
    ///
    /// Be sure to call next when returning, unless you don't want the
    /// request to be handled.
    ///
    /// - Parameter request: The incoming request to intercept, then
    ///   pass along the handler chain.
    /// - Throws: Any error encountered when intercepting the request.
    func intercept(_ request: Request, next: @escaping Next) throws -> EventLoopFuture<Response> {
        let start = Date()
        Log.info("\(request.head.method.rawValue) \(request.path)")
        return next(request)
            .map { response in
                let elapsedTime = String(format: "%.2fs", Date().timeIntervalSince(start))
                Log.info("\(response.status.code) \(request.head.method.rawValue) \(request.path) \(elapsedTime)")
                return response
            }
    }
}
