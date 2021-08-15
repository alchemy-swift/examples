import SwiftUI

struct CreateTodoView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State private var name: String = ""
    @ObservedObject private var storage = Storage.shared
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Name", text: self.$name).field()
                Spacer()
                Button("Create", action: self.createTodo)
            }
            .padding()
            .navigationTitle("Create Todo")
        }
    }
    
    private func createTodo() {
        guard !name.isEmpty else {
            return
        }
        
        storage.createTodo(name: name)
        presentationMode.wrappedValue.dismiss()
    }
}
