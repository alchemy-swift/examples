import Alchemy
import Shared

struct TodoController: Controller {
    /// The API interface.
    private let api = TodoAPI()
    
    /// Add this controller's handlers to a router.
    ///
    /// - Parameter router: The Router on which to add handlers.
    func route(_ app: Application) {
        app
            .on(api.getAll, use: getAll)
            .on(api.create, use: create)
            .on(api.delete, use: delete)
            .on(api.complete, use: complete)
    }
    
    private func getAll(req: Request) async throws -> [TodoDTO] {
        let user = try req.get(User.self)
        return try await Todo.allWhere("user_id" == user.id).map { $0.dto }
    }
    
    private func create(req: Request, dto: CreateTodoRequest) async throws -> TodoDTO {
        let user = try req.get(User.self)
        return try await Todo(name: dto.name, isComplete: false, user: user).insertReturn().dto
    }
    
    private func delete(req: Request, dto: DeleteTodoRequest) async throws {
        let user = try req.get(User.self)
        try await Todo
            .where("id" == dto.todoID)
            .where("user_id" == user.id)
            .delete()
    }
    
    private func complete(req: Request, dto: CompleteTodoRequest) async throws -> TodoDTO {
        guard var todo = try await Todo
                .where("id" == dto.todoID)
                .where("user_id" == req.get(User.self).id)
                .first() else { throw HTTPError(.notFound) }
        todo.isComplete = !todo.isComplete
        return try await todo.save().dto
    }
}

private extension Todo {
    /// Creates a new token for this user.
    var dto: TodoDTO {
        TodoDTO(id: try! getID(), name: name, isComplete: isComplete)
    }
}
