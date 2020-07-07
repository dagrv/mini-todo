//  EmptyListView.swift
//  mini-todos
//
//  Created by rust on 07/07/2020.
//  Copyright © 2020 rust. All rights reserved.

import SwiftUI

struct EmptyListView: View {
    //MARK: - Properties
    @State private var isAnimated: Bool = false
    
    let images: [String] = [
        "illustration-no1",
        "illustration-no2"
    ]
    
    let tips: [String] = [
        "Do what you love and keep it simple.",
        "Do your best",
        "Never regret",
        "Hard tasks first",
        "Procrastination never helped anyone",
        "Start today",
        "Look in the mirror before you get out of the car"
    ]
    
    //MARK: - Body
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 20) {
                Image("\(images.randomElement() ?? self.images[0])")
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 256, idealWidth: 280, maxWidth: 360, minHeight: 256, idealHeight: 280, maxHeight: 360, alignment: .center)
                    .layoutPriority(1)
                
                Text("\(tips.randomElement() ?? self.tips[0] )")
                    .layoutPriority(0.5)
                    .font(.system(.headline, design: .rounded))
            } //: END VStack
                .padding(.horizontal)
                .opacity(isAnimated ? 1 : 0)
                .offset(y: isAnimated ? 0 : -50)
                .animation(.easeOut(duration: 1.5))
                .onAppear(perform: {
                    self.isAnimated.toggle()
                })
        } //: END ZStack
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color("ColorBase"))
            .edgesIgnoringSafeArea(.all)
    }
}

//MARK: - Preview
struct EmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyListView().environment(\.colorScheme, .dark)
    }
}
