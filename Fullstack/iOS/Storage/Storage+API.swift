import PapyrusAlamofire
import Shared

private enum API {
    static let baseURL = "http://localhost:3000"
    static let auth = AuthAPI(baseURL: baseURL)
    static let todo = TodoAPI(baseURL: baseURL, getToken: { Storage.shared.authToken })
}

// Simple extensions for loading the APIs defined with Papyrus.
extension Storage {
    
    // MARK: - AuthAPI
    
    func signup(name: String, email: String, password: String) {
        let request = AuthAPI.SignupRequest(name: name, email: email, password: password)
        API.auth.signup.request(request) {
            self.authToken = $0.value
        }
    }
    
    func login(email: String, password: String) {
        let request = AuthAPI.LoginRequest(email: email, password: password)
        API.auth.login.request(request) {
            self.authToken = $0.value
        }
    }
    
    // MARK: - TodoAPI
    
    func getTodos() {
        API.todo.getAll.request(.value) {
            self.todos = $0
        }
    }
    
    func createTodo(name: String) {
        let request = TodoAPI.CreateTodoRequest(name: name)
        API.todo.create.request(request) {
            self.todos.append($0)
        }
    }
    
    func deleteTodo(_ todo: Todo) {
        let request = TodoAPI.DeleteTodoRequest(todoID: String(todo.id))
        API.todo.delete.request(request) { _ in
            self.todos.removeAll(where: { $0.id == todo.id })
        }
    }
    
    func completeTodo(_ todo: Todo) {
        let request = TodoAPI.CompleteTodoRequest(todoID: String(todo.id))
        API.todo.complete.request(request) { todo in
            guard let index = self.todos.firstIndex(where: { $0.id == todo.id }) else {
                return
            }
            
            self.todos[index] = todo
        }
    }
}

extension Endpoint {
    func request(_ req: Request, completion: @escaping (Response) -> Void) {
        request(req) { _, result in
            switch result {
            case .success(let res):
                completion(res)
            case .failure(let error):
                print("Error completing a todo: \(error).")
            }
        }
    }
}
