import Papyrus

public final class TodoAPI: EndpointGroup {
    @GET("/todo")            public var getAll: Endpoint<Empty, [TodoDTO]>
    @POST("/todo")           public var create: Endpoint<CreateTodoRequest, TodoDTO>
    @DELETE("/todo/:todoID") public var delete: Endpoint<DeleteTodoRequest, Empty>
    @PATCH("/todo/:todoID")  public var complete: Endpoint<CompleteTodoRequest, TodoDTO>
    
    public let baseURL: String
    public let getToken: (() -> String?)?
    
    /// Server initializer; will be providing the endpoints so it
    /// doesn't need any baseURL or token.
    public init() {
        self.baseURL = ""
        self.getToken = nil
    }
    
    /// Client initializer; will be requesting the endpoints so it
    /// will need a baseURL and token closure.
    public init(baseURL: String, getToken: @escaping () -> String?) {
        self.baseURL = baseURL
        self.getToken = getToken
    }
    
    public func intercept(_ components: inout HTTPComponents) {
        if let token = getToken?() {
            components.headers["Authorization"] = "Bearer \(token)"
        }
    }
}

extension TodoAPI {
    /// Request data for creating a new todo.
    public struct CreateTodoRequest: RequestBody {
        public let name: String
            
        public init(name: String) {
            self.name = name
        }
    }
    
    /// Request data for deleting a todo.
    public struct DeleteTodoRequest: RequestComponents {
        @Path public var todoID: String
        
        public init(todoID: String) {
            self.todoID = todoID
        }
    }
    
    /// Request data for completing a todo.
    public struct CompleteTodoRequest: RequestComponents {
        @Path public var todoID: String
        
        public init(todoID: String) {
            self.todoID = todoID
        }
    }
    
    /// A todo item, with associated tags.
    public struct TodoDTO: Codable, Identifiable {
        public let id: Int
        public let name: String
        public let isComplete: Bool
        
        public init(id: Int, name: String, isComplete: Bool) {
            self.id = id
            self.name = name
            self.isComplete = isComplete
        }
    }
}
