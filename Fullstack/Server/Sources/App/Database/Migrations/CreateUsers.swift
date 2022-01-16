import Alchemy

struct CreateUsers: Migration {
    func up(schema: Schema) {
        schema.create(table: "users") {
            $0.increments("id").primary()
            $0.string("name").notNull()
            $0.string("email").notNull().unique()
            $0.string("password").notNull()
        }
        
        schema.create(table: "user_tokens") {
            $0.increments("id").primary()
            $0.string("value").notNull()
            $0.date("created_at").notNull()
            $0.bigInt("user_id").notNull().references("id", on: "users")
        }
    }
    
    func down(schema: Schema) {
        schema.drop(table: "user_tokens")
        schema.drop(table: "users")
    }
}
