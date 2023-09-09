import Alchemy

extension App {

    /// Configurations related to your app's databases.

    var databases: Databases {
        Databases(

            /// Your default Database

            default: .sqlite /* Env.isTesting ? .sqlite : .postgres */,

            /// Define your databases here

            databases: [
                .postgres: .postgres(
                    host: Env.DB_HOST ?? "localhost",
                    port: Env.DB_PORT ?? 5432,
                    database: Env.DB ?? "db",
                    username: Env.DB_USER ?? "user",
                    password: Env.DB_PASSWORD ?? "password",
                    enableSSL: Env.DB_ENABLE_SSL ?? false
                ),
                .sqlite: .sqlite(),
            ],

            /// Migrations for your app

            migrations: [
                Queue.AddJobsMigration(),
                CreateUsers(),
            ],

            /// Seeders for your database

            seeders: [
                SeedUsers()
            ],

            /// Your default Redis

            defaultRedis: .primary,

            /// Any redis connections can be defined here

            redis: [
                .primary: .connection(
                    Env.REDIS_HOST ?? "localhost",
                    port: Env.REDIS_PORT ?? 6379
                ),
            ]
        )
    }
}

extension Database.Identifier {
    static let sqlite: Database.Identifier = "sqlite"
    static let postgres: Database.Identifier = "postgres"
}

extension RedisClient.Identifier {
    static let primary: RedisClient.Identifier = "primary"
}
