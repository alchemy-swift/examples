import SwiftUI

struct AuthView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLogin: Bool = false
    @State private var showAlert: Bool = false
    
    var body: some View {
        VStack {
            VStack {
                Text(isLogin ? "Login" : "Signup")
                    .font(.title)
                if !isLogin {
                    TextField("Your name", text: $name).field()
                }
                TextField("Email", text: $email).field()
                SecureField("Password", text: $password).field()
            }.padding()
            VStack(spacing: 16) {
                Button(isLogin ? "Login" : "Signup", action: isLogin ? login : signup)
                Button(isLogin ? "Signup instead" : "Login instead") { isLogin.toggle() }
            }.padding()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Invalid info"), message: Text("Ensure all fields are filled in."))
        }
    }
    
    private func login() {
        guard !email.isEmpty && !password.isEmpty else {
            showAlert = true
            return
        }
        
        Storage.shared.login(email: email, password: password)
    }
    
    private func signup() {
        guard !name.isEmpty && !email.isEmpty && !password.isEmpty else {
            showAlert = true
            return
        }
        
        Storage.shared.signup(name: name, email: email, password: password)
    }
}

extension View {
    func field() -> some View {
        padding(.leading, 24)
            .frame(height: 54)
            .background(Color(red: 0.925, green: 0.941, blue: 0.945))
            .cornerRadius(4)
    }
}
