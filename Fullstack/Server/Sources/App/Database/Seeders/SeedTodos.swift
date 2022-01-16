import Alchemy

struct SeedTodos: Seeder {
    func run() async throws {
        try await User.seed(10)
        try await Todo.seed(100)
    }
}

extension Todo: Seedable {
    static func generate() async throws -> Todo {
        try await Todo(name: faker.lorem.words(), isComplete: faker.number.randomBool(), user: .random()!)
    }
}

extension User: Seedable {
    static func generate() async throws -> User {
        User(email: faker.internet.email(), password: faker.internet.password(), name: faker.name.name())
    }
}
