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
    
    private func signup(req: Request, dto: AuthAPI.SignupRequest) throws -> EventLoopFuture<AuthAPI.TokenDTO> {
        let conflictError = HTTPError(.conflict, message: "A user with that email exists.")
        return User
            .ensureNotExists("email" == dto.email, else: conflictError)
            .flatMapThrowing {
                User(email: dto.email, password: try Bcrypt.hash(dto.password), name: dto.name)
            }
            .flatMap { $0.save() }
            .flatMap { $0.createNewToken() }
            .map { AuthAPI.TokenDTO(value: $0.value) }
    }
    
    private func login(req: Request, dto: AuthAPI.LoginRequest) throws -> EventLoopFuture<AuthAPI.TokenDTO> {
        User.authenticate(username: dto.email, password: dto.password)
            .flatMap { $0.createNewToken() }
            .map { AuthAPI.TokenDTO(value: $0.value) }
    }
}

private extension User {
    /// Creates a new token for this user.
    func createNewToken() -> EventLoopFuture<UserToken> {
        return UserToken(user: .init(self))
            .save()
    }
}
