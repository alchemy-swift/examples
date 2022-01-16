import Alchemy

struct UserToken: Model, TokenAuthable {
    static let userKey = \UserToken.$user
    
    var id: Int?
    var value = UUID().uuidString
    var createdAt = Date()
    
    @BelongsTo var user: User
}
