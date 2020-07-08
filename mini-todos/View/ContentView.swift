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
    
    @EnvironmentObject var iconSettings: IconNames
    
    @State private var showingSettingsView: Bool = false
    @State private var showingAddTodoView: Bool = false
    @State private var animatingButton: Bool = false
    
    
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
                    // EDIT Button
                    leading: EditButton(),
                    
                    // ADD Button
                    trailing:
                    Button(action: {
                        self.showingSettingsView.toggle()
                    }) {
                        Image(systemName: "gear").imageScale(.large)
                    } //: END (+) Add Button
                    
                    .sheet(isPresented: $showingSettingsView) {
                        SettingsView().environmentObject(self.iconSettings)
                    }
                    
                )
                
                //MARK: - No Todos
                if todos.count == 0 {
                    EmptyListView()
                }
                
            } //: END ZStack
            .sheet(isPresented: $showingAddTodoView) {
                AddTodoView().environment(\.managedObjectContext, self.managedObjectContext)
            }
        .overlay(
            ZStack {
                
                // Circles (+) Bottom Button
                Group {
                    Circle()
                        .fill(Color.blue)
                        .opacity(self.animatingButton ? 0.6 : 0)
                        .scaleEffect(self.animatingButton ? 1 : 0)
                        .frame(width: 68, height: 68, alignment: .center)
                    
                    Circle()
                        .fill(Color.blue)
                        .opacity(self.animatingButton ? 0.3 : 0)
                        .scaleEffect(self.animatingButton ? 1 : 0)
                        .frame(width: 88, height: 88, alignment: .center)
                }
                .animation(Animation.easeInOut(duration: 4).repeatForever(autoreverses: true))
                
                Button(action: {
                    self.showingAddTodoView.toggle()
                }) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.white)
                        .background(Circle().fill(Color.black)) //MARK: TO CHANGE IF NOT OK ON DARK MODE
                        .frame(width: 50, height: 50, alignment: .center)
                } //: END Button
                .onAppear(perform: {
                    self.animatingButton.toggle()
                })
            } //: END ZStack
                .padding(.bottom, 13)
            .padding(.trailing, 25)
            , alignment: .bottomTrailing
        )
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
