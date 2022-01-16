import Alchemy

struct AuthController: Controller {
    /// Add this controller's handlers to a router.
    ///
    /// - Parameter router: The Router on which to add handlers.
    func route(_ app: Application) {
        app.post("/signup", use: signup)
        
        // Only apply basic auth middleware to the `/login` endpoint.
        app.group(User.basicAuthMiddleware()) {
            $0.post("/login", use: login)
        }
    }
    
    private func signup(req: Request) async throws -> UserToken {
        struct SignupBody: Codable {
            let email: String
            let password: String
        }
        
        let body = try req.decode(SignupBody.self)
        return try await User(email: body.email, password: Bcrypt.hash(body.password))
            .save()
            .createToken()
    }
    
    private func login(req: Request) async throws -> UserToken {
        try await req.get(User.self).createToken()
    }
}

private extension User {
    /// Creates a new token for this user.
    func createToken() async throws -> UserToken {
        try await UserToken(user: self).save()
    }
}
