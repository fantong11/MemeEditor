//
//  CanvasView.swift
//  MemeEditor
//
//  Created by 范桶 on 2022/5/2.
//

import SwiftUI
import PencilKit

struct CanvasView: UIViewRepresentable {
    
    @Binding var canvas: PKCanvasView
    @Binding var toolPicker: PKToolPicker
    @Binding var image: UIImage?
    
    var rect: CGSize
    
    func makeUIView(context: Context) -> some UIView {
        canvas.isOpaque = false
        canvas.backgroundColor = .clear
        canvas.drawingPolicy = .anyInput
        
        if let image = image {
            
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: 0 , y: 0, width: rect.width, height: rect.height)
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = false
            
            // Make the base image the bottom layer of the canvas
            let subView = canvas.subviews[0]
            subView.addSubview(imageView)
            subView.sendSubviewToBack(imageView)
            
            // Show tool picker and make canvas aware of tool changes
            toolPicker.setVisible(true, forFirstResponder: canvas)
            toolPicker.addObserver(canvas)
            canvas.becomeFirstResponder()
        }
        return canvas
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        var count = 0
        // Update the frame incase GeometryReader changes (e.g. NavigationBar added to the view)
        for subviews in canvas.subviews {
            for subview in subviews.subviews {
                //                print(type(of: subview))
                if let imageView = subview as? UIImageView {
                    count += 1
                    imageView.frame = CGRect(x: 0 , y: 0, width: rect.width, height: rect.height)
                }
            }
        }
        //        print("\(count) image views found")
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(canvasView: $canvas, toolPicker: toolPicker)
    }
    
    class Coordinator: NSObject, PKCanvasViewDelegate {
        var canvasView: Binding<PKCanvasView>
        private let toolPicker: PKToolPicker
        init(canvasView: Binding<PKCanvasView>, toolPicker: PKToolPicker) {
            self.canvasView = canvasView
            self.toolPicker = toolPicker
        }
        deinit {
            toolPicker.setVisible(false, forFirstResponder: canvasView.wrappedValue)
            toolPicker.removeObserver(canvasView.wrappedValue)
        }
    }
}
