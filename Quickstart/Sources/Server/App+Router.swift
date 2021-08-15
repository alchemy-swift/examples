import Alchemy

extension App {
    /// Configure the application's route handlers.
    func router() {
        useAll(LoggingMiddleware())
        useAll(StaticFileMiddleware())

        get("/hello") { _ in
            return HomeView(greetings: ["Hola", "Bonjour", "Hello", "Hallo", "Ola"], name: "Josh")
        }
        
        controller(AuthController())
        
        // Authenticate subsequent requests by token.
        use(UserToken.tokenAuthMiddleware())
        
        get("/email") { req -> String in
            let user = try req.get(User.self)
            return user.email
        }
    }
}
