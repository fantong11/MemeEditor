//
//  StickerList.swift
//  MemeEditor
//
//  Created by 范桶 on 2022/6/15.
//

import Foundation

class StickerList {
    var stickers: [Sticker]
    var editIndex: Int = 0
    
    init(stickers: [Sticker]) {
        self.stickers = stickers
    }
}
