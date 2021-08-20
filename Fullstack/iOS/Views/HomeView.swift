import Foundation
import SwiftUI

struct HomeView: View {
    @ObservedObject private var storage = Storage.shared
    @State private var showCreate = false
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(storage.todos) { todo in
                        HStack {
                            Text(todo.name)
                                .font(.title2)
                            Spacer()
                            Image(systemName: todo.isComplete ? "checkmark.square": "square")
                        }
                        .padding(5.0)
                        .background(Color.white)
                        .onTapGesture { toggle(todo: todo) }
                    }
                    .onDelete(perform: delete)
                }
                .listStyle(InsetGroupedListStyle())
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        ActionButton { showCreate = true }
                    }
                }
            }
            .toolbar { Button("Logout", action: storage.logout) }
            .navigationTitle("My Todos")
            .onAppear { storage.getTodos() }
            .sheet(isPresented: $showCreate, content: { CreateTodoView() })
        }
    }
    
    private func delete(at offsets: IndexSet) {
        for index in offsets {
            let todo = storage.todos.remove(at: index)
            storage.deleteTodo(todo)
        }
    }
    
    private func toggle(todo: Todo) {
        storage.completeTodo(todo)
    }
}
