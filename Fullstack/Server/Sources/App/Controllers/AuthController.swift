import Alchemy
import Shared

struct AuthController: Controller {
    /// The API interface.
    private let api = AuthAPI()
    
    /// Add this controller's handlers to a router.
    ///
    /// - Parameter router: The Router on which to add handlers.
    func route(_ app: Application) {
        app
            .on(api.signup, use: signup)
            .on(api.login, use: login)
    }
    
    private func signup(req: Request, dto: SignupRequest) async throws -> TokenDTO {
        guard try await User.find("email" == dto.email) == nil else {
            throw HTTPError(.conflict, message: "A user with that email exists.")
        }
        
        let passwordHash = try await Bcrypt.hash(dto.password)
        return try await User(email: dto.email, password: passwordHash, name: dto.name).save().createToken().dto
    }
    
    private func login(req: Request, dto: LoginRequest) async throws -> TokenDTO {
        try await User.authenticate(username: dto.email, password: dto.password).createToken().dto
    }
}

private extension UserToken {
    var dto: TokenDTO {
        TokenDTO(value: value)
    }
}

private extension User {
    /// Creates a new token for this user.
    func createToken() async throws -> UserToken {
        try await UserToken(user: self).save()
    }
}
