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
    var graphic: [Graphic] = []
    
    init(id: UUID = UUID(), name: String, image: UIImage?) {
        self.id = id
        self.name = name
        self.image = image
    }
    
    func add(graphic: Graphic) {
        self.graphic.append(graphic)
    }
    
    func size() -> Int {
        return graphic.count
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
