import Alchemy

struct CreateUsersTable: Migration {
    /// Run the migrations.
    func up(schema: Schema) {
        schema.create(table: "users") {
            $0.increments("id").primary()
            $0.string("name").notNull()
            $0.string("email").notNull().unique()
        }
    }
    
    /// Reverse the migrations.
    func down(schema: Schema) {
        schema.drop(table: "users")
    }
}
