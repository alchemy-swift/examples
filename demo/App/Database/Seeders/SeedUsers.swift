import Alchemy

struct SeedUsers: Seeder {
    func run() async throws {
        try await User.seed(5)
        try await UserToken.seed(5)
    }
}

extension UserToken: Seedable {
    static func generate() async throws -> UserToken {
        let userId = try await User.randomOrSeed().id()
        return UserToken(userId: userId)
    }
}

extension User: Seedable {
    static func generate() -> User {
        User(email: faker.internet.email(), password: faker.internet.password())
    }
}
