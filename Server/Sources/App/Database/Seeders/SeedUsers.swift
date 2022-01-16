import Alchemy

struct SeedUsers: Seeder {
    func run() async throws {
        try await User.seed(10)
    }
}

extension User: Seedable {
    static func generate() async throws -> User {
        User(email: faker.internet.email(), password: faker.internet.password())
    }
}
