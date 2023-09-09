import Alchemy

struct LogUsers: Command {
    
    /// Run this command with `swift run app log:users`

    static let name = "log:users"

    func run() async throws {
        for user in try await User.all() {
            Log.info("\(user.email)")
        }
    }
}
