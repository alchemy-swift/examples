import Alchemy

struct User: Model, BasicAuthable {
    var id: Int?
    var email: String
    var password: String
    var name: String
    
    @HasMany var todos: [Todo]
}
