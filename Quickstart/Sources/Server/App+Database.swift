import Alchemy

extension App {
    /// Configure the application's SQL databases.
    func database() {
        Database.config(default: .postgres(
            host: Env.DB_HOST,
            database: "alchemy",
            username: "",
            password: ""
        ))
        
        Database.config("mysql", .mysql(
            host: Env.DB_HOST,
            database: "alchemy",
            username: "",
            password: ""
        ))
        
        Database.default.migrations = [
            CreateUsersTable()
        ]
    }
}
