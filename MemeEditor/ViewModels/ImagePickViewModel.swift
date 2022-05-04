//
//  ImagePickVIewModel.swift
//  MemeEditor
//
//  Created by 范桶 on 2022/3/10.
//

import Foundation
import UIKit
import SwiftUI

class ImagePickViewModel: ObservableObject {
    @Published var showingImagePicker: Bool = false
    @Published var inputImage: UIImage?
    
    @Published var creations: [Creation] = []
    
    init() {
        
    }
    
    func loadImage() -> Image? {
        guard let inputImage = inputImage else { return nil }
        return Image(uiImage: inputImage)
    }
}
