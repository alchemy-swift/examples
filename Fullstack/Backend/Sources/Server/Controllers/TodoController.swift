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
    
    private func getAll(req: Request) throws -> EventLoopFuture<[TodoAPI.TodoDTO]> {
        let user = try req.get(User.self)
        return Todo
            .allWhere("user_id" == user.id)
            .mapEach { $0.toDTO() }
    }
    
    private func create(req: Request, dto: TodoAPI.CreateTodoRequest) throws -> EventLoopFuture<TodoAPI.TodoDTO> {
        let user = try req.get(User.self)
        return Todo(name: dto.name, isComplete: false, user: .init(user))
            .insert()
            .map { $0.toDTO() }
    }
    
    private func delete(req: Request, dto: TodoAPI.DeleteTodoRequest) throws -> EventLoopFuture<Empty> {
        let user = try req.get(User.self)
        return Todo
            .where("id" == Int(dto.todoID))
            .where("user_id" == user.id)
            .delete()
            .emptied()
    }
    
    private func complete(req: Request, dto: TodoAPI.CompleteTodoRequest) throws -> EventLoopFuture<TodoAPI.TodoDTO> {
        let user = try req.get(User.self)
        return Todo
            .where("id" == Int(dto.todoID))
            .where("user_id" == user.id)
            .with(\.$user)
            .unwrapFirst(or: HTTPError(.notFound))
            .flatMap { todo in
                todo.update { $0.isComplete = !$0.isComplete }
            }
            .map { $0.toDTO() }
    }
}

private extension Todo {
    /// Creates a new token for this user.
    func toDTO() -> TodoAPI.TodoDTO {
        return TodoAPI.TodoDTO(id: try! getID(), name: name, isComplete: isComplete)
    }
}
