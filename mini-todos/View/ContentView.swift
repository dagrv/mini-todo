//  ContentView.swift
//  mini-todos
//
//  Created by rust on 06/07/2020.
//  Copyright © 2020 rust. All rights reserved.

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: Todo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)]) var todos: FetchedResults<Todo>
    
    @State private var showingAddTodoView: Bool = false
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            
            ZStack {
                List {
                    ForEach(self.todos, id: \.self) { todo in
                        HStack {
                            Text(todo.name ?? "Undefined")
                            Spacer()
                            Text(todo.priority ?? "Undefined")
                        } //: END HStack
                    } //: END ForEach
                    
                    .onDelete(perform: deleteTodo)
                    
                } //: END List
                .navigationBarTitle("All")
                .navigationBarItems(
                    leading: EditButton(),
                    trailing:
                    Button(action: {
                        self.showingAddTodoView.toggle()
                    }) {
                        Image(systemName: "plus.app.fill").imageScale(.large)
                    } //: END (+) Add Button
                    
                    .sheet(isPresented: $showingAddTodoView) {
                        AddTodoView().environment(\.managedObjectContext, self.managedObjectContext)
                    }
                    
                )
                
                //MARK: - No Todos
                if todos.count == 0 {
                    EmptyListView()
                }
                
            } //: END ZStack
        } //: END NavigationView
    }
    
    //MARK: - Functions (swipe left to delete)
    private func deleteTodo(at offsets: IndexSet) {
        for index in offsets {
            let todo = todos[index]
            managedObjectContext.delete(todo)
            
            do {
                try managedObjectContext.save()
            } catch {
                print(error)
            }
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return ContentView()
            .environment(\.managedObjectContext, context)
    }
}
