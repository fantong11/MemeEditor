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
    var points: CGPoint { get set }
    var size: CGSize { get set }
}

struct TextBox2: Graphic {
    var points: CGPoint
    var size: CGSize
    
    var text = ""
    var isBold = true
    
    var offset: CGSize = .zero
    var lastOffset: CGSize = .zero
    var textColor: Color = .white
    
    var isAdded = false
}
