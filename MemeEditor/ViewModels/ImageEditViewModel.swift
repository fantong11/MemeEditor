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
    
    @Published var textBoxes = [TextBox]()
    @Published var addingTextBox = false
    @Published var currentIndex = 0
    
    // For saving image
    @Published var rect: CGRect = .zero
    
    @Published var showingAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    
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
        textBoxes.append(TextBox())
        currentIndex = textBoxes.count - 1
        withAnimation {
            addingTextBox.toggle()
        }
    }
    
    
    func cancelTextBoxView() {
        withAnimation {
            addingTextBox = false
        }
        if !textBoxes[currentIndex].isAdded {
            textBoxes.removeLast()
        } else {
            textBoxes.remove(at: currentIndex)
        }
        currentIndex = 0
    }
    func getIndex(of textBox: TextBox) -> Int {
        textBoxes.firstIndex { box -> Bool in
            textBox.id == box.id
        } ?? 0
    }
    func saveImage() {
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        
        //canvas
        canvas.drawHierarchy(in: CGRect(origin: .zero, size: rect.size), afterScreenUpdates: true)
        
        //SwiftUI
        let swiftUIView = ZStack {
            ForEach(textBoxes) { [self] textBox in
                Text(textBoxes[currentIndex].id == textBox.id && addingTextBox ? "" : textBox.text)
                    .font(.system(size: 30))
                    .fontWeight(textBox.isBold ? .bold : .regular)
                    .foregroundColor(textBox.textColor)
                    .offset(textBox.offset)
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
