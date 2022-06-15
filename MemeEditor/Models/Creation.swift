//
//  Creation.swift
//  MemeEditor
//
//  Created by 范桶 on 2022/5/2.
//

import Foundation
import UIKit

class Creation: Identifiable {
    var id: UUID
    var name: String
    var image: UIImage?
    var graphics: [Graphic] = []
    var stickerList: StickerList = StickerList(stickers: [])
    var textBoxList: TextBoxList = TextBoxList(textBoxes: [])
    
    init(id: UUID = UUID(), name: String, image: UIImage?) {
        self.id = id
        self.name = name
        self.image = image
    }
    
//    func add(graphic: Graphic) {
//        self.graphic.append(graphic)
//    }
    
    func addTextBoxes(textBox: TextBox) {
        self.textBoxList.textBoxes.append(textBox)
    }
    
    func addStickers(sticker: Sticker) {
        self.stickerList.stickers.append(sticker)
    }
    
//    func size() -> Int {
//        return graphic.count
//    }
    
    func textBoxesSize() -> Int {
        return textBoxList.textBoxes.count
    }
    
    func stickersSize() -> Int {
        return stickerList.stickers.count
    }
}

extension Creation {
    static var sampleData: [Creation] {
        [
            Creation(name: "test1", image: UIImage(named: "hello-peter")!),
            Creation(name: "test2", image: UIImage(named: "hello-peter")!),
            Creation(name: "test3", image: UIImage(named: "hello-peter")!)
        ]
    }
}
