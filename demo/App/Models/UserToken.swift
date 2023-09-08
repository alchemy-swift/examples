import Alchemy

struct UserToken: Model, Codable, Timestamped, TokenAuthable {
    typealias Authorizes = User

    var id: PK<Int> = .new
    var value = UUID().uuidString
    var userId: Int

    var user: BelongsTo<User> {
        belongsTo()
    }
}
