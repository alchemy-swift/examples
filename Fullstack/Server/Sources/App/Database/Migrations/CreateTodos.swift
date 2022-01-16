import Alchemy

struct CreateTodos: Migration {
    func up(schema: Schema) {
        schema.create(table: "todos") {
            $0.increments("id").primary()
            $0.string("name").notNull()
            $0.bool("is_complete").notNull()
            $0.bigInt("user_id").references("id", on: "users").notNull()
        }
    }
    
    func down(schema: Schema) {
        schema.drop(table: "todos")
    }
}
