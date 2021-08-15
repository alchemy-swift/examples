import Foundation
import SwiftUI

struct HomeView: View {
    @State private var showActionSheet: Bool = false
    @State private var showCreate = false
    
    @ObservedObject private var storage = Storage.shared
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(storage.todos) { todo in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(todo.name)
                                    .font(.title2)
                            }
                            Spacer()
                            Image(systemName: todo.isComplete ? "checkmark.square": "square")
                        }
                        .padding(5.0)
                        .background(Color.white)
                        .onTapGesture {
                            toggle(todo: todo)
                        }
                    }
                    .onDelete(perform: delete)
                }
                .listStyle(InsetGroupedListStyle())
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        ActionButton { showActionSheet = true }
                    }
                }
            }
            .navigationTitle("Your Todos")
            .onAppear {
                storage.getTodos()
            }
            .actionSheet(isPresented: $showActionSheet) {
                ActionSheet(
                    title: Text("Create"),
                    buttons: [
                        .default(Text("Todo")) { showCreate = true },
                        .cancel(Text("Cancel")),
                    ])
            }
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
