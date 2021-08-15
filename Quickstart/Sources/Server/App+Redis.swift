import Alchemy

extension App {
    /// Configure the application's Redis provider.
    func redis() {
        Redis.config(default: .connection("localhost"))
        
        Redis.config("cluster", .cluster(
            .ip(host: "49.236.44.61", port: 6379),
            .ip(host: "49.236.44.61", port: 6380),
            .ip(host: "244.226.128.50", port: 6379),
            .ip(host: "180.166.115.70", port: 6379),
            .unix(path: "/path/to/redis")
        ))
    }
}
