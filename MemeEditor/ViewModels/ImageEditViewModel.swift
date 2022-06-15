//
//  ImageEditViewModel.swift
//  MemeEditor
//
//  Created by Ian Liu on 3/19/22.
//

import SwiftUI
import PencilKit

class ImageEditViewModel: ObservableObject {
    @Published var canvas = PKCanvasView()
    @Published var toolPicker = PKToolPicker()
    @Published var isDrawing = false
    
    @Published var addingTextBox = false
    
    // For saving image
    @Published var rect: CGRect = .zero
    
    @Published var showingAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    
    @Published var creation: Creation
    
    init(creation: Creation) {
        self.creation = creation
    }
    
    
    @Published var isShowingStickerSheet = false
//    @Published var currentStickerName = ""
    
    @Published var isShowingEditSheet = false
    
    var showingFeaturesToolBar: Bool {
        return !addingTextBox
    }
    
    func startDrawing() {
        // show tool picker
        toolPicker.setVisible(true, forFirstResponder: canvas)
        canvas.becomeFirstResponder()
        canvas.isUserInteractionEnabled = true
        isDrawing = true
    }
    
    func doneDrawing() {
        // Close the tool picker
        toolPicker.setVisible(false, forFirstResponder: canvas)
        canvas.resignFirstResponder()
        canvas.isUserInteractionEnabled = false
        isDrawing = false
    }
    
    func createTextBox() {
        guard !addingTextBox else { return }
        // Create a new text box
        creation.textBoxList.textBoxes.append(TextBox())
        creation.textBoxList.currentIndex = creation.textBoxList.textBoxes.count - 1
        withAnimation {
            addingTextBox.toggle()
        }
    }
    
    func addTextBox() {
        creation.textBoxList.textBoxes[creation.textBoxList.currentIndex].isAdded = true
        addingTextBox = false
    }
    
    func cancelTextBoxView() {
        withAnimation {
            addingTextBox = false
        }
        if !creation.textBoxList.textBoxes[creation.textBoxList.currentIndex].isAdded {
            creation.textBoxList.textBoxes.removeLast()
        } else {
            creation.textBoxList.textBoxes.remove(at: creation.textBoxList.currentIndex)
        }
        creation.textBoxList.currentIndex = 0
    }
    
    func getIndex(of textBox: TextBox) -> Int {
        creation.textBoxList.textBoxes.firstIndex { box -> Bool in
            textBox.id == box.id
        } ?? 0
    }
    
    func getIndex(of sticker: Sticker) -> Int {
        creation.stickerList.stickers.firstIndex { s -> Bool in
            sticker.id == s.id
        } ?? 0
    }
    
    func addSticker(_ sticker: Sticker) {
        creation.stickerList.stickers.append(sticker)
    }
    
    // used in sticker edit view
    func removeSticker(_ sticker: Sticker) {
        isShowingEditSheet = false
        creation.stickerList.stickers.remove(at: creation.stickerList.editIndex)
        creation.stickerList.editIndex = 0
    }
    
    func saveImage() {
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        
        //canvas
        canvas.drawHierarchy(in: CGRect(origin: .zero, size: rect.size), afterScreenUpdates: true)
        
        //SwiftUI
        let swiftUIView = ZStack {
            ForEach(creation.textBoxList.textBoxes) { textBox in
                Text(textBox.text)
                    .font(.system(size: 30))
                    .fontWeight(textBox.isBold ? .bold : .regular)
                    .foregroundColor(textBox.textColor)
                    .offset(textBox.offset)
            }
            ForEach(creation.stickerList.stickers) { sticker in
                Image(sticker.name)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100 * sticker.scale)
                    .opacity(sticker.opacity)
                    .rotationEffect(.degrees(sticker.rotation))
                    .offset(sticker.offset)
            }
        }
        
        let controller = UIHostingController(rootView: swiftUIView).view!
        controller.frame = rect
        
        
        controller.backgroundColor = .clear
        canvas.backgroundColor = .clear
        
        
        controller.drawHierarchy(in: CGRect(origin: .zero, size: rect.size), afterScreenUpdates: true)
        
        // getting image
        let generatedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        guard let image = generatedImage?.pngData() else { print("Error: Can't generate image"); return }
        UIImageWriteToSavedPhotosAlbum(UIImage(data: image)!, nil, nil, nil)
        alertTitle = "Enjoy!"
        alertMessage = "Image saved to your photo library"
        showingAlert = true
    }
}
