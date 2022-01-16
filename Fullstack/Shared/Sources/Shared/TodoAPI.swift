import Papyrus

public struct TodoAPI {
    @GET("/todo")            public var getAll = Endpoint<Empty, [TodoDTO]>()
    @POST("/todo")           public var create = Endpoint<CreateTodoRequest, TodoDTO>()
    @DELETE("/todo/:todoID") public var delete = Endpoint<DeleteTodoRequest, Empty>()
    @PATCH("/todo/:todoID")  public var complete = Endpoint<CompleteTodoRequest, TodoDTO>()
    
    public init() {}
}

/// Request data for creating a new todo.
public struct CreateTodoRequest: EndpointRequest {
    public let name: String
        
    public init(name: String) {
        self.name = name
    }
}

/// Request data for deleting a todo.
public struct DeleteTodoRequest: EndpointRequest {
    @Path public var todoID: Int
    
    public init(todoID: Int) {
        self.todoID = todoID
    }
}

/// Request data for completing a todo.
public struct CompleteTodoRequest: EndpointRequest {
    @Path public var todoID: Int
    
    public init(todoID: Int) {
        self.todoID = todoID
    }
}

/// A todo item, with associated tags.
public struct TodoDTO: EndpointResponse, Identifiable {
    public let id: Int
    public let name: String
    public let isComplete: Bool
    
    public init(id: Int, name: String, isComplete: Bool) {
        self.id = id
        self.name = name
        self.isComplete = isComplete
    }
}

extension Array: EndpointResponse where Element: Codable {}
