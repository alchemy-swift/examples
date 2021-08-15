import Papyrus

public final class AuthAPI: EndpointGroup {
    @POST("/signup") public var signup: Endpoint<SignupRequest, TokenDTO>
    @POST("/login")  public var login: Endpoint<LoginRequest, TokenDTO>
    
    public let baseURL: String
    
    public init(baseURL: String) {
        self.baseURL = baseURL
    }
}

extension AuthAPI {
    /// Request data for creating a new user.
    public struct SignupRequest: RequestBody {
        public let name: String
        public let email: String
        public let password: String
        
        public init(name: String, email: String, password: String) {
            self.name = name
            self.email = email
            self.password = password
        }
    }
    
    /// Request data for logging in.
    public struct LoginRequest: RequestBody {
        public let email: String
        public let password: String
        
        public init(email: String, password: String) {
            self.email = email
            self.password = password
        }
    }
    
    /// An auth token to include in an "Authorization: Bearer ..."
    /// header.
    public struct TokenDTO: Codable {
        public let value: String
        
        public init(value: String) {
            self.value = value
        }
    }
}
