import Alchemy

struct UsersController: Controller {
    
    /// Add this controller's handlers and middleware to a router.
    func route(_ router: Router) {
        router
            .post("/signup", use: signup)

            // Basic auth middleware will only run before the `/user` endpoint.
        
            .group(User.basicAuthMiddleware())
            .post("/login", use: login)

        router
            
            // Token auth middleware will only run before the `/user` endpoint.

            .group(UserToken.tokenAuthMiddleware())
            .get("/user", use: getUser)
    }

    private func signup(req: Request) async throws -> UserToken {
        struct SignupBody: Codable {
            let email: String
            let password: String
        }

        let body = try req.decode(SignupBody.self)
        guard try await User.firstWhere("email" == body.email) == nil else {
            throw HTTPError(.conflict)
        }

        return try await User(email: body.email, password: Hash.make(body.password))
            .save()
            .createToken()
    }
    
    private func login(req: Request) async throws -> UserToken {
        try await req.get(User.self).createToken()
    }

    private func getUser(req: Request) async throws -> Response {
        let user = try req.get(User.self)
        return try Response(status: .ok, dict: ["id": user.id, "email": user.email])
    }
}

private extension User {
    /// Creates a new token for this user.
    func createToken() async throws -> UserToken {
        try await UserToken(userId: id()).save()
    }
}
