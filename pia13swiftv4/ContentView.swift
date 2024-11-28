//
//  ContentView.swift
//  pia13swiftv4
//
//  Created by BillU on 2024-11-25.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    
    @State var isLoggedin : Bool?
    
    var body: some View {
        VStack {
            if isLoggedin == true {
                TodoView()
            }
            if isLoggedin == false {
                LoginView()
            }
        }
        .onAppear() {
            Auth.auth().addStateDidChangeListener { auth, user in
                print("USER CHANGE")
                
                if Auth.auth().currentUser == nil {
                    isLoggedin = false
                } else {
                    isLoggedin = true
                }
                
            }
        }
    }
    
    
}

#Preview {
    ContentView()
}
