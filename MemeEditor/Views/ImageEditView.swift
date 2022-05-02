//
//  ImageEditView.swift
//  MemeEditor
//
//  Created by Ian Liu on 3/18/22.
//

import SwiftUI
import PencilKit

struct ImageEditView: View {
    @StateObject var viewModel = ImageEditViewModel()
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
                TextBoxView(textBox: textBox)
            }
            
            if viewModel.addingTextBox {
                AddTextBoxView(isTextBoxFocused: _isTextBoxFocused)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save", action: viewModel.saveImage)
                    .disabled(viewModel.addingTextBox)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.createTextBox()
                    isTextBoxFocused.toggle()
                } label: {
                    Image(systemName: "plus")
                }
                    .disabled(viewModel.addingTextBox)
            }
        }
        .alert(viewModel.alertTitle, isPresented: $viewModel.showingAlert) {
            Button("OK") { }
        } message: {
               Text(viewModel.alertMessage)
        }
        .environmentObject(viewModel)
    }
}

struct ImageEditView_Previews: PreviewProvider {
    static var previews: some View {
        ImageEditView(baseImage: .constant(UIImage(named: "hello-peter")!))
    }
}





