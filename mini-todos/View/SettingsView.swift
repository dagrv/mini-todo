//  SettingsView.swift
//  mini-todos
//
//  Created by rust on 07/07/2020.
//  Copyright © 2020 rust. All rights reserved.

import SwiftUI



struct SettingsView: View {
    //MARK: - Properties
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var iconSettings: IconNames
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                Form {
                    // MARK: - Section' 2
                    Section(header: Text("")) {
                        Picker(selection: $iconSettings.currentIndex, label: Text("App Icon")) {
                            ForEach(0..<iconSettings.iconNames.count) { index in
                                HStack {
                                    Image(uiImage: UIImage(named: self.iconSettings.iconNames[index] ?? "BlueDark") ?? UIImage())
                                        .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 45, height: 45)
                                    .cornerRadius(9)
                                    
                                    Spacer().frame(width: 8)
                                    
                                    Text(self.iconSettings.iconNames[index] ?? "Blue")
                                        .frame(alignment: .leading)
                                } //: END HStack
                                .padding(3)
                            } //: END ForEach
                        } //: END Picker
                        .onReceive([self.iconSettings.currentIndex].publisher.first()) { (value) in
                            let index = self.iconSettings.iconNames.firstIndex(of: UIApplication.shared.alternateIconName) ?? 0
                            if index != value {
                                UIApplication.shared.setAlternateIconName(self.iconSettings.iconNames[value]) { error in
                                    if let error = error {
                                        print(error.localizedDescription)
                                    } else {
                                        print("Success! Icon Changed. ")
                                    }
                                }
                            }
                        }
                    } //: END Section
                    .padding(.vertical, 3)
                    
                    
                    // MARK: - Section' 3
                    Section(header: Text("")) {
                        FormRowLinkView(icon: "globe", color: Color.red, text: "Website", link: "https://rustx.co")
                        FormRowLinkView(icon: "t.circle.fill", color: Color(.systemTeal), text: "Twitter", link: "https://twitter.com/91Rust")
                        FormRowLinkView(icon: "g.circle.fill", color: Color.black, text: "GitHub", link: "https://github.com/7rust")
                    } //: END Section 4
                    .padding(.vertical, 3)
                    
                    // MARK: - Section' 4
                    Section(header: Text("")) {
                        FormRowStaticView(icon: "gear", firstText: "Application", secondText: "mini-todo")
                        FormRowStaticView(icon: "person.crop.circle", firstText: "Developer", secondText: "Rust C.")
                        FormRowStaticView(icon: "flag.circle", firstText: "Version", secondText: "1.2.1")
                    } //: END Section 4
                    .padding(.vertical, 3)
                    
                } // END: Form
                    .listStyle(GroupedListStyle())
                    .environment(\.horizontalSizeClass, .regular)
                
                
                //MARK: Footer
                Text("Copyright © All rights reserved\n Rustin Spencer Cohle")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding(.top, 6)
                    .padding(.bottom, 8)
                    .foregroundColor(Color.secondary)
            } //: END VStack
            .navigationBarItems(trailing:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                }
            )
            .navigationBarTitle(Text("Settings"))
            .background(Color("ColorBackground").edgesIgnoringSafeArea(.all))
        } //: END Navigation
    }
}

//MARK: - Preview
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(IconNames())
    }
}
