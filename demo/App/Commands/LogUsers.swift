import Alchemy

struct LogUsers: Command {
    
    /// Run this command with `swift run app print:users`

    static let name = "print:users"

    func run() async throws {
        for user in try await User.all() {
            Log.info("\(user.email)")
        }
    }
}
