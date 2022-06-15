//
//  GraphicFactory.swift
//  MemeEditor
//
//  Created by 范桶 on 2022/6/15.
//

import Foundation

enum GraphicType {
    case textbox
    case sticker
}


enum GraphicFactory {
    static func graphic(for graphicType: GraphicType) -> Graphic {
        switch graphicType {
        case .textbox:
            return TextBox()
        case .sticker:
            return Sticker(name: "")
        }
    }
}
