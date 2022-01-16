import Alchemy

struct Todo: Model {
    var id: Int?
    var name: String
    var isComplete: Bool
    
    @BelongsTo var user: User
}
