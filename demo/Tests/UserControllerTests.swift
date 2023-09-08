@testable import App
import AlchemyTest

final class UsersTests: TestCase<App> {
    let (email, password) = ("foo@example.com", "password1")
    let tokenValue = UUID().uuidString
    let userId = 1

    override func setUp() async throws {
        try await super.setUp()

        // Fake the hasher so that passwords can be easily validated and won't be expensive to hash.
        Hasher.fake()

        // Run migrations on the test database and add a test user & token.
        try await DB.migrate()
        let user = try await User(id: .new(userId), email: email, password: password).save()
        try await UserToken(value: tokenValue, userId: user.id()).insert()
    }

    func testSignup() async throws {
        try await Test.withBody(["email": "foo@bar.com", "password": "baz"])
            .post("/signup")
            .assertOk()
            .assertBodyHasFields("value")

        try await Test.withBody(["email": email, "password": "baz"])
            .post("/signup")
            .assertStatus(.conflict)
    }

    func testLogin() async throws {
        try await Test.post("/login")
            .assertUnauthorized()
        
        try await Test.withBasicAuth(username: "foo", password: "bar")
            .post("/login")
            .assertUnauthorized()

        try await Test.withBasicAuth(username: email, password: password)
            .post("/login")
            .assertOk()
            .assertBodyHasFields("value")
    }

    func testGetUser() async throws {
        try await Test.get("/user")
            .assertUnauthorized()

        try await Test.withToken(tokenValue)
            .get("/user")
            .assertOk()
            .assertJsonDict(["id": userId, "email": email])
    }
}
