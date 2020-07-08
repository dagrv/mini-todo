//  ThemeSettings.swift
//  mini-todos
//
//  Created by rust on 08/07/2020.
//  Copyright © 2020 rust. All rights reserved.

import SwiftUI

//MARK: - Theme Class

class ThemeSettings: ObservableObject {
    @Published var themeSettings: Int = UserDefaults.standard.integer(forKey: "Theme") {
        didSet {
            UserDefaults.standard.set(self.themeSettings, forKey: "Theme")
        }
    }
}
