import Alchemy

extension Database: Configurable {
    public static var config: Config {
        Config(
            databases: [
                .default: .postgres(
                    host: Env.DB_HOST ?? "localhost",
                    database: Env.DB ?? "db",
                    username: Env.DB_USER ?? "user",
                    password: Env.DB_PASSWORD ?? "password"
                ),
                .mysql: .mysql(
                    host: Env.DB_HOST ?? "localhost",
                    database: Env.DB ?? "db",
                    username: Env.DB_USER ?? "user",
                    password: Env.DB_PASSWORD ?? "password"
                )
            ],
            migrations: [
                // Migrations
                Queue.AddJobsMigration(),
                CreateUsers()
            ],
            seeders: [
                SeedUsers()
            ],
            redis: [
                .default: .connection("localhost"),
                .cluster: .cluster(
                    .ip(host: "49.236.44.61", port: 6379),
                    .ip(host: "49.236.44.61", port: 6380),
                    .ip(host: "244.226.128.50", port: 6379),
                    .ip(host: "180.166.115.70", port: 6379),
                    .unix(path: "/path/to/redis")
                )
            ]
        )
    }
}

extension RedisClient.Identifier {
    static let cluster: RedisClient.Identifier = "cluster"
}

extension Database.Identifier {
    static let mysql: Database.Identifier = "mysql"
}
