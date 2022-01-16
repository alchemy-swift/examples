import Alchemy

extension Queue: Configurable {
    public static var config: Config {
        Config(
            queues: [
                .default: .memory,
                .sql: .database
            ],
            jobs: [
                .job(CleanupTokens.self)
            ]
        )
    }
}

extension Queue.Identifier {
    static let sql: Queue.Identifier = "sql"
}
