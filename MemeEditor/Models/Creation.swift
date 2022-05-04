//
//  Creation.swift
//  MemeEditor
//
//  Created by 范桶 on 2022/5/2.
//

import Foundation
import UIKit

class Creation {
    var name: String
    var image: UIImage
    var graphic: [Graphic] = []
    
    init(name: String, image: UIImage) {
        self.name = name
        self.image = image
    }
    
    
}
