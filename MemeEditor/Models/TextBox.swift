//
//  TextBox.swift
//  MemeEditor
//
//  Created by Ian Liu on 3/19/22.
//

import SwiftUI
import PencilKit

struct TextBox: Identifiable {
    var id = UUID()
    var text = ""
    var isBold = true
    
    var offset: CGSize = .zero
    var lastOffset: CGSize = .zero
    var textColor: Color = .white
    
    var isAdded = false
}
