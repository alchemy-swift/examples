import Alchemy

struct UserToken: Model, TokenAuthable {
    static let userKey = \UserToken.$user
    
    var id: Int?
    var value: String = UUID().uuidString
    var createdAt: Date = Date()
    
    @BelongsTo var user: User
}
