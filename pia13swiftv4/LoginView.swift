//
//  LoginView.swift
//  pia13swiftv4
//
//  Created by BillU on 2024-11-28.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

struct LoginView: View {
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        VStack {
            Text("LOGIN")
            TextField("Email", text: $email)
            TextField("Password", text: $password)

            Button(action: {
                Task {
                    await userLogin()
                }
            }) {
                Text("Login")
            }
            Button(action: {
                Task {
                    await userRegister()
                }
            }) {
                Text("Register")
            }
        }
        .padding()
    }
    
    func userLogin() async {
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
        } catch {
            print("FEL LOGIN")
        }
    }
    
    func userRegister() async {
        do {
            let regResult = try await Auth.auth().createUser(withEmail: email, password: password)
            
            
        } catch {
            print("FEL REG")
        }
    }
    
}

#Preview {
    LoginView()
}
