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
            
            ForEach(viewModel.stickers) { sticker in
                StickerView(sticker: sticker)
            }
            
            ForEach(viewModel.textBoxes) { textBox in
                TextBoxView(textBox: textBox)
            }
            
            
            // feature select toolbar
            VStack {
                HStack {
                    if !viewModel.isDrawing {
                        Button("Drawing") {
                            viewModel.startDrawing()
                        }
                        Button("Text") {
                            viewModel.createTextBox()
                            isTextBoxFocused.toggle()
                        }
                        Button("Sticker") {
                            viewModel.isShowingStickerSheet = true
                        }
                    }
                    else {
                        Button {
                            viewModel.doneDrawing()
                        } label: {
                            Text("Done")
                                .fontWeight(.bold)
                        }
                    }
                }
                .padding(8)
                // .frame(maxWidth: .infinity, alignment: .center) // make width consistent
                .foregroundColor(.white)
                .background(Color.secondary)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding([.leading, .trailing])
                
                Spacer()
            }
            .opacity(viewModel.showingFeaturesToolBar ? 1 : 0)
            
            if viewModel.addingTextBox {
                AddTextBoxView(isTextBoxFocused: _isTextBoxFocused)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save Image", action: viewModel.saveImage)
                    .disabled(viewModel.addingTextBox)
            }
        }
        .sheet(isPresented: $viewModel.isShowingStickerSheet, content: {
            StickerSelectView()
        })
        .sheet(isPresented: $viewModel.isShowingEditSheet, content: {
            StickerEditView()
        })
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





