//  ContentView.swift
//  mini-todos
//
//  Created by rust on 06/07/2020.
//  Copyright © 2020 rust. All rights reserved.

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var showingAddTodoView: Bool = false
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            List(0 ..< 5) { item in
                Text("Hello")
            } //: List
            .navigationBarTitle("All")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showingAddTodoView.toggle()
                }) {
                    Image(systemName: "plus.app.fill").imageScale(.large)
                } //: END (+) Add Button
                
                .sheet(isPresented: $showingAddTodoView) {
                    AddTodoView().environment(\.managedObjectContext, self.managedObjectContext)
                }
                
            )
        } //: END NavigationView
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
