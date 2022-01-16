import Alchemy

// Run this command with `swift run App print:users`
struct LogUsers: Command {
    static let configuration = CommandConfiguration(commandName: "print:users")
    
    func start() async throws {
        for user in try await User.all() {
            Log.info("\(user.email)")
        }
    }
}
