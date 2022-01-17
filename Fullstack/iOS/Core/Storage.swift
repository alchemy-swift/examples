import PapyrusAlamofire
import Shared
import SwiftUI

typealias Todo = TodoDTO

/// Provides central, observable repository of app data for SwiftUI
/// views to hook up to.
final class Storage: ObservableObject {
    static let shared = Storage()
    
    @Published var todos: [Todo] = []
    @Published var authToken: String? = nil {
        didSet {
            UserDefaults().setValue(self.authToken, forKey: "auth_token")
        }
    }
    
    private let authAPI = Provider(api: AuthAPI())
    private let todoAPI = Provider(api: TodoAPI())
    
    init() {
        authToken = UserDefaults().string(forKey: "auth_token")
    }
    
    func logout() {
        authToken = nil
    }
    
    // MARK: - AuthAPI
    
    func signup(name: String, email: String, password: String) {
        let request = SignupRequest(name: name, email: email, password: password)
        authAPI.signup.request(request) {
            self.authToken = $0.value
        }
    }
    
    func login(email: String, password: String) {
        let request = LoginRequest(email: email, password: password)
        authAPI.login.request(request) {
            self.authToken = $0.value
        }
    }
    
    // MARK: - TodoAPI
    
    func getTodos() {
        guard authToken != nil else { return }
        todoAPI.getAll.request {
            self.todos = $0
        }
    }
    
    func createTodo(name: String) {
        let request = CreateTodoRequest(name: name)
        todoAPI.create.request(request) {
            self.todos.append($0)
        }
    }
    
    func deleteTodo(_ todo: Todo) {
        let request = DeleteTodoRequest(todoID: todo.id)
        todoAPI.delete.request(request) { _ in
            self.todos.removeAll(where: { $0.id == todo.id })
        }
    }
    
    func completeTodo(_ todo: Todo) {
        let request = CompleteTodoRequest(todoID: todo.id)
        todoAPI.complete.request(request) { todo in
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
                print("Error making a request to \(path): \(error).")
            }
        }
    }
}

extension Endpoint where Request == Papyrus.Empty {
    func request(completion: @escaping (Response) -> Void) {
        request { _, result in
            switch result {
            case .success(let res):
                completion(res)
            case .failure(let error):
                print("Error making a request to \(path): \(error).")
            }
        }
    }
}
