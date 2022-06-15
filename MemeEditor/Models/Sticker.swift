//
//  Sticker.swift
//  MemeEditor
//
//  Created by Ian Liu on 6/14/22.
//

import SwiftUI


struct Sticker: Identifiable {
    var id = UUID()
    var name: String
    
    var offset: CGSize = .zero
    var lastOffset: CGSize = .zero
    var scale: CGFloat = 1.0
    
    var rotation: Double = 0.0
    var opacity: Double = 1.0
}
