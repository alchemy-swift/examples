import Alchemy

struct AuthController: Controller {
    /// Add this controller's handlers to a router.
    ///
    /// - Parameter router: The Router on which to add handlers.
    func route(_ app: Application) {
        app.post("/signup", handler: signup)
        
        // Only apply basic auth middleware to the `/login` endpoint.
        app.group(middleware: User.basicAuthMiddleware()) {
            $0.post("/login", handler: login)
        }
    }
    
    private func signup(req: Request) throws -> EventLoopFuture<UserToken> {
        struct SignupBody: Codable {
            let email: String
            let password: String
        }
        
        let body: SignupBody = try req.decodeBody()
        let newUser = User(email: body.email, password: try Bcrypt.hash(body.password))
        return newUser.save()
            .flatMap { $0.createNewToken() }
    }
    
    private func login(req: Request) throws -> EventLoopFuture<UserToken> {
        return try req.get(User.self)
            .createNewToken()
    }
}

private extension User {
    /// Creates a new token for this user.
    func createNewToken() -> EventLoopFuture<UserToken> {
        return UserToken(user: self).save()
    }
}
