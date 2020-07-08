//  ThemeModel.swift
//  mini-todos
//
//  Created by rust on 08/07/2020.
//  Copyright © 2020 rust. All rights reserved.

import Foundation
import SwiftUI

// MARK: Theme Model
struct Theme: Identifiable {
    let id: Int
    let themeName: String
    let themeColor: Color
}
