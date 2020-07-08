//  FormRowStaticView.swift
//  mini-todos
//
//  Created by rust on 07/07/2020.
//  Copyright © 2020 rust. All rights reserved.

import SwiftUI

struct FormRowStaticView: View {
    //MARK: - Properties
    var icon: String
    var firstText: String
    var secondText: String
    
    //MARK: - Body
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color(red: 0, green: 0.7, blue: 0.3))
                Image(systemName: icon).foregroundColor(Color.white).imageScale(.large)
            }
            .frame(width: 36, height: 36, alignment: .center)
            
            Text(firstText).foregroundColor(Color.green)
            Spacer()
            Text(secondText).foregroundColor(Color.blue)
        }
    }
}

//MARK: - Properties
struct FormRowStaticView_Previews: PreviewProvider {
    static var previews: some View {
        FormRowStaticView(icon: "gear", firstText: "Application", secondText: "mini-todo")
            .previewLayout(.fixed(width: 375, height: 60))
            .padding()
    }
}
