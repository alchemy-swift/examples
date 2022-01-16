import Alchemy

struct User: Model, BasicAuthable {
    var id: Int?
    let email: String
    let password: String
}
