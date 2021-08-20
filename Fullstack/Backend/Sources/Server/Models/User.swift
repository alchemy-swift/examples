import Alchemy

struct User: Model, BasicAuthable {
    static var tableName: String = "users"
    
    var id: Int?
    var email: String
    var password: String
    var name: String
}
