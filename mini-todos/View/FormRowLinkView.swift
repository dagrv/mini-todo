//  FormRowLinkView.swift
//  mini-todos
//
//  Created by rust on 07/07/2020.
//  Copyright © 2020 rust. All rights reserved.

import SwiftUI

struct FormRowLinkView: View {
    //MARK: - Properties
    var icon: String
    var color: Color
    var text: String
    var link: String
    
    //MARK: - Body
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(color)
                Image(systemName: icon)
                    .imageScale(.large)
                    .foregroundColor(Color.white)
            } //: END ZStack
            .frame(width: 36, height: 36, alignment: .center)
            Text(text)
            Spacer()
            Button(action: {
                guard let url = URL(string: self.link), UIApplication.shared.canOpenURL(url) else {
                    return
                }
                UIApplication.shared.open(url as URL)
                
            }) {
                Image(systemName: "chevron.right")
                    .imageScale(.large)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
            }
            .accentColor(Color.blue)
        } //: END HStack
    }
}

//MARK: - Preview
struct FormRowLinkView_Previews: PreviewProvider {
    static var previews: some View {
        FormRowLinkView(icon: "t.circle.fill", color: Color(.systemTeal), text: "Twitter", link: "https://twitter.com/91Rust")
            .previewLayout(.fixed(width: 375, height: 60))
            .padding()
    }
}
