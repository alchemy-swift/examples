import Alchemy

extension App {
    /// Use this function to configure the application's SQL databases.
    func database() {
        Database.config(default: .postgres(
            host: Env.DB_HOST ?? "localhost",
            database: Env.DB ?? "db",
            username: Env.DB_USER ?? "user",
            password: Env.DB_PASSWORD ?? "password"
        ))
        
        Database.config("mysql", .mysql(
            host: "localhost",
            database: "db",
            username: "user",
            password: "password"
        ))
        
        Database.default.migrations = [
            Queue.AddJobsMigration(),
            CreateUsersTable()
        ]
    }
}
