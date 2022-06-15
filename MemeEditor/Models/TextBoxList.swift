//
//  TextBoxList.swift
//  MemeEditor
//
//  Created by 范桶 on 2022/6/15.
//

import Foundation

class TextBoxList {
    var textBoxes: [TextBox]
    var currentIndex: Int = 0
    
    init(textBoxes: [TextBox]) {
        self.textBoxes = textBoxes
    }
}
