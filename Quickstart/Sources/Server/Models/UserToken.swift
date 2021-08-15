import Alchemy

struct UserToken: Model, TokenAuthable {
    static var tableName: String = "user_tokens"
    static var userKey: KeyPath<UserToken, BelongsTo<User>> = \.$user
    
    var id: Int?
    var value: String = UUID().uuidString
    var createdAt: Date = Date()
    
    @BelongsTo var user: User
}
