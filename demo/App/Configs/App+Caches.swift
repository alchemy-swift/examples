import Alchemy

extension App {

    /// Configurations related to your app's caches.

    var caches: Caches {
        Caches(

            /// Your app's default Cache

            default: .database,

            /// Define your caches here

            caches: [
                .database: .database(),
                .redis: .redis(),
            ]
        )
    }
}

extension Cache.Identifier {
    static let database: Cache.Identifier = "database"
    static let redis: Cache.Identifier = "redis"
}
