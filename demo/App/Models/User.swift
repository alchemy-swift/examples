import Alchemy

struct User: Model, Codable, Timestamped, BasicAuthable {
    var id: PK<Int> = .new
    let email: String
    let password: String
}
