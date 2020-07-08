//  AddTodoView.swift
//  mini-todos
//
//  Created by rust on 06/07/2020.
//  Copyright © 2020 rust. All rights reserved.

import SwiftUI

struct AddTodoView: View {
    
    // MARK: - Properties
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name: String = ""
    @State private var priority: String = "Normal"
    
    let priorities = ["High", "Normal", "Low"]
    
    @State private var errorShowing: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    
    //MARK: Accent Color Modifier
    @ObservedObject var theme = ThemeSettings()
    var themes: [Theme] = themeData
    
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading, spacing: 20) {
                    // MARK: - Todo Name
                    TextField("Todo", text: $name)
                        .padding()
                        .background(Color(UIColor.tertiarySystemFill))
                        .cornerRadius(10)
                        .font(.system(size: 23, weight: .semibold, design: .default))
                    
                    // MARK: - Todo Priority
                    Picker("Priority", selection: $priority) {
                        ForEach(priorities, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    //MARK: - Save Button
                    Button(action: {
                        if self.name != "" {
                            let todo = Todo(context: self.managedObjectContext)
                            todo.name = self.name
                            todo.priority = self.priority
                            
                            do {
                                try self.managedObjectContext.save()
                                //print("New Todo = \(todo.name ?? ""), Priority: \(todo.priority ?? "")")
                            } catch {
                                print(error)
                            }
                        } else {
                            self.errorShowing = true
                            self.errorTitle = "Invalid Name"
                            self.errorMessage = "Todo name required !"
                            
                            return
                        }
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Save").font(.system(size: 23, weight: .semibold, design: .default))
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(themes[self.theme.themeSettings].themeColor)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                    } //: END Save Button
                } //: END VStack
                    .padding(.horizontal)
                .padding(.vertical, 30)
                
                Spacer()
                
            } //: END VStack
            .navigationBarTitle("New")
            .navigationBarItems(trailing:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                }
            )
            
            .alert(isPresented: $errorShowing) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("Cool")))
            }
        } //: END Navigation
        .accentColor(themes[self.theme.themeSettings].themeColor)
    }
}

// MARK: - Preview
struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}
