//
//  ImageEditView.swift
//  MemeEditor
//
//  Created by Ian Liu on 3/18/22.
//

import SwiftUI
import PencilKit

struct ImageEditView: View {
    @ObservedObject var viewModel = ViewModel()
    @Binding var baseImage: UIImage?
    @FocusState private var isTextBoxFocused: Bool
    
    var body: some View {
        ZStack(alignment: .center) {
            GeometryReader { geometry -> CanvasView in
                DispatchQueue.main.async {
                    viewModel.rect = geometry.frame(in: .global)
                }
                return CanvasView(canvas: $viewModel.canvas, toolPicker: $viewModel.toolPicker, image: $baseImage, rect: geometry.frame(in: .global).size)
            }
            
            ForEach(viewModel.textBoxes) { textBox in
                Text(viewModel.textBoxes[viewModel.currentIndex].id == textBox.id && viewModel.addingTextBox ? "" : textBox.text)
                    .font(.system(size: 30))
                    .fontWeight(textBox.isBold ? .bold : .regular)
                    .foregroundColor(textBox.textColor)
                    .offset(textBox.offset)
                    .gesture(DragGesture().onChanged({ value in
                        let current = value.translation
                        let last = textBox.lastOffset
                        let newTranslation = CGSize(width: last.width + current.width, height: last.height + current.height)
                        viewModel.textBoxes[viewModel.getIndex(of: textBox)].offset = newTranslation
                    }).onEnded({ value in
                        viewModel.textBoxes[viewModel.getIndex(of: textBox)].lastOffset = value.translation
                    }))
                    .onLongPressGesture {
                        // Edit text box
                        viewModel.toolPicker.setVisible(false, forFirstResponder: viewModel.canvas)
                        viewModel.canvas.resignFirstResponder()
                        viewModel.currentIndex = viewModel.getIndex(of: textBox)
                        withAnimation {
                            viewModel.addingTextBox = true
                        }
                    }
            }
            
            if viewModel.addingTextBox {
                Color.black
                    .opacity(0.5)
                    .ignoresSafeArea()
                TextField("Type Here", text: $viewModel.textBoxes[viewModel.currentIndex].text)
                    .font(.system(size: 35, weight: viewModel.textBoxes[viewModel.currentIndex].isBold ? .bold : .regular))
                    .foregroundColor(viewModel.textBoxes[viewModel.currentIndex].textColor)
                    .padding()
                    .preferredColorScheme(.dark)
                    .focused($isTextBoxFocused)
                HStack {
                    Button {
                        viewModel.textBoxes[viewModel.currentIndex].isAdded = true
                        viewModel.toolPicker.setVisible(true, forFirstResponder: viewModel.canvas)
                        viewModel.canvas.becomeFirstResponder()
                        withAnimation {
                            viewModel.addingTextBox = false
                        }
                    } label: {
                        Text("Add")
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button(action: viewModel.cancelTextBoxView) {
                        Image(systemName: "xmark")
                    }
                    .foregroundColor(.white)
                }
                .overlay {
                    HStack(spacing: 15) {
                        ColorPicker("Set the text color", selection: $viewModel.textBoxes[viewModel.currentIndex].textColor)
                        .labelsHidden()
                        Button {
                            viewModel.textBoxes[viewModel.currentIndex].isBold.toggle()
                        } label: {
                            Text(viewModel.textBoxes[viewModel.currentIndex].isBold ? "Noraml" : "Bold")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding()
                .frame(maxHeight: .infinity, alignment: .top)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save", action: viewModel.saveImage)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // Create a new text box
                    viewModel.textBoxes.append(TextBox())
                    viewModel.currentIndex = viewModel.textBoxes.count - 1
                    withAnimation {
                        viewModel.addingTextBox.toggle()
                    }
                    // Close the tool picker
                    viewModel.toolPicker.setVisible(false, forFirstResponder: viewModel.canvas)
                    viewModel.canvas.resignFirstResponder()
                    isTextBoxFocused.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .alert(viewModel.alertTitle, isPresented: $viewModel.showingAlert) {
            Button("OK") { }
        } message: {
               Text(viewModel.alertMessage)
        }
    }
}

struct ImageEditView_Previews: PreviewProvider {
    static var previews: some View {
        ImageEditView(baseImage: .constant(UIImage(named: "hello-peter")!))
    }
}


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
