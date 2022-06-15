//
//  Graphic.swift
//  MemeEditor
//
//  Created by 范桶 on 2022/5/2.
//

import Foundation
import UIKit
import SwiftUI

protocol Graphic {
    var offset: CGSize { get set }
    var lastOffset: CGSize { get set }
}

class TextBox2: Graphic, Identifiable {
    var id: UUID = UUID()
    var text = ""
    var isBold = true
    var offset: CGSize = .zero
    var lastOffset: CGSize = .zero
    var textColor: Color = .white
    var isAdded = false
}
