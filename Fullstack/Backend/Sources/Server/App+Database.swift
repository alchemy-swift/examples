import Alchemy

extension App {
    /// Use this function to configure the application's SQL databases.
    func database() {
        Database.config(default: .postgres(
            host: Env.DB_HOST,
            database: "alchemy",
            username: "josh",
            password: "password"
        ))
        
        Database.config("mysql", .mysql(
            host: Env.DB_HOST,
            database: "alchemy",
            username: "user",
            password: "password"
        ))
        
        Database.default.migrations = [
            CreateUsersTable(),
            CreateTodosTable()
        ]
    }
}
