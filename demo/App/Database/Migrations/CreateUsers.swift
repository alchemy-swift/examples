import Alchemy

struct CreateUsers: Migration {
    /// Run the migrations.
    func up(db: Database) async throws {
        try await db.createTable("users") {
            $0.increments("id").primary()
            $0.string("email").notNull().unique()
            $0.string("password").notNull()
            $0.timestamps()
        }
        
        try await db.createTable("user_tokens") {
            $0.increments("id").primary()
            $0.string("value").notNull()
            $0.bigInt("user_id").notNull().references("id", on: "users")
            $0.timestamps()
        }
    }
    
    /// Reverse the migrations.
    func down(db: Database) async throws {
        try await db.dropTable("user_tokens")
        try await db.dropTable("users")
    }
}
