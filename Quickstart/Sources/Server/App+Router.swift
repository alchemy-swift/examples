import Alchemy

extension App {
    /// Configure the application's route handlers.
    func router() {
        useAll(LoggingMiddleware())
        useAll(StaticFileMiddleware(from: "public/"))
        
        controller(AuthController())
        
        // Authenticate subsequent requests by token.
        use(UserToken.tokenAuthMiddleware())
        get("/email") { req -> String in
            let user = try req.get(User.self)
            return user.email
        }
    }
}
