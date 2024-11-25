//
//  ContentView.swift
//  pia13swiftv4
//
//  Created by BillU on 2024-11-25.
//

import SwiftUI
import Firebase

class Todo {
    var id = ""
    var title = ""
}


struct ContentView: View {
    
    @State var todoadd = ""
    
    @State var todolist = [Todo]()
    
    var body: some View {
        VStack {
            HStack {
                TextField("TODO", text: $todoadd)
                Button(action: {
                    todosave()
                }) {
                    Text("ADD")
                }
            }
            
            List(todolist, id: \.id) { todoitem in
                VStack {
                    Text(todoitem.id)
                    Text(todoitem.title)
                }
            }
            
        }
        .padding()
        .onAppear() {
            //fbtest()
            
            
        }
        .task {
            //await fbtestload()
            await todoload()
        }
    }
    
    func todoload() async {
        var ref: DatabaseReference!

        ref = Database.database().reference()
        
        todolist = []
        
        do {
            let tododata = try await ref.child("todo").getData()
            print(tododata.childrenCount)
            
            for todoitem in tododata.children {
                let todosnap = todoitem as! DataSnapshot
                
                let tododict = todosnap.value as? [String: String]
                
                
                print(tododict!["title"])
                
                var faketodo = Todo()
                faketodo.id = todosnap.key
                faketodo.title = tododict!["title"]!
                
                todolist.append(faketodo)
                
            }
            
        } catch {
            // Något gick fel
            print("Nu blev det fel!!!")
        }
    }
    
    func todosave() {
        var ref: DatabaseReference!

        ref = Database.database().reference()
        
        ref.child("todo").childByAutoId().child("title").setValue(todoadd)
        
        Task {
            await todoload()
        }
    }
    
    func fbtestsave() {
        var ref: DatabaseReference!

        ref = Database.database().reference()
        
        ref.child("fruit").setValue("orange")
    }
    
    func fbtestload() async {
        var ref: DatabaseReference!

        ref = Database.database().reference()
        
        do {
            let namndata = try await ref.child("namn").getData()
            if let thename = namndata.value as? String {
                print(thename)
            }
            
            
        } catch {
            // Något gick fel
            print("Nu blev det fel!!!")
        }
    }
    
}

#Preview {
    ContentView()
}
