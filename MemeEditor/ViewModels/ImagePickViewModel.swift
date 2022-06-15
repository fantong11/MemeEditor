//
//  ImagePickViewModel.swift
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
    @Published var isInputing: Bool = false
    var tempName: String = ""
    @Published var selectedCreation: Int?
    
    init() {
        
    }
    
    init(creations: [Creation]) {
        self.creations = creations
    }
    
    init(creations: [Creation], selectedCreation: Int) {
        self.creations = creations
        self.selectedCreation = selectedCreation
    }
    
    func loadImage() -> Image? {
        guard let inputImage = inputImage else { return nil }
        return Image(uiImage: inputImage)
    }
    
    func addCreation(creation: Creation) {
        creations.append(creation)
    }
    
    func deleteCreation(at offsets: IndexSet) {
        creations.remove(atOffsets: offsets)
    }
}
