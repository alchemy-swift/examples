import PapyrusAlamofire
import Shared
import SwiftUI

typealias Todo = TodoAPI.TodoDTO

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
    
    init() {
        authToken = UserDefaults().string(forKey: "auth_token")
    }
    
    func logout() {
        authToken = nil
    }
}
