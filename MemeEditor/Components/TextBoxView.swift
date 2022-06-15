//
//  TextBoxView.swift
//  MemeEditor
//
//  Created by 范桶 on 2022/5/2.
//

import SwiftUI

struct TextBoxView: View {
    @EnvironmentObject var viewModel: ImageEditViewModel
    let textBox: TextBox
    
    var body: some View {
        // check array empty state first to prevent  "Fatal error: Index out of range"
        Text(!viewModel.creation.textBoxList.textBoxes.isEmpty && viewModel.creation.textBoxList.textBoxes[viewModel.creation.textBoxList.currentIndex].id == textBox.id && viewModel.addingTextBox ? "" : textBox.text)
            .font(.system(size: 30))
            .fontWeight(textBox.isBold ? .bold : .regular)
            .foregroundColor(textBox.textColor)
            .offset(textBox.offset)
            .gesture(DragGesture()
                .onChanged{ value in
                    let current = value.translation
                    let last = textBox.lastOffset
                    let newTranslation = CGSize(width: last.width + current.width, height: last.height + current.height)
                    viewModel.creation.textBoxList.textBoxes[viewModel.getIndex(of: textBox)].offset = newTranslation
                }
                .onEnded{ value in
                    viewModel.creation.textBoxList.textBoxes[viewModel.getIndex(of: textBox)].lastOffset = value.translation
                }
            )
            .gesture(LongPressGesture()
                .onEnded{ _ in
                    // Edit text box
                    viewModel.toolPicker.setVisible(false, forFirstResponder: viewModel.canvas)
                    viewModel.canvas.resignFirstResponder()
                    // 之後改abstract可以不用index
                    viewModel.creation.textBoxList.currentIndex = viewModel.getIndex(of: textBox)
                    withAnimation {
                        viewModel.addingTextBox = true
                    }
                }
            )
//            .onLongPressGesture {
//                // Edit text box
//                viewModel.toolPicker.setVisible(false, forFirstResponder: viewModel.canvas)
//                viewModel.canvas.resignFirstResponder()
//                viewModel.currentIndex = viewModel.getIndex(of: textBox)
//                withAnimation {
//                    viewModel.addingTextBox = true
//                }
//            }
    }
}

//struct TextBoxView_Previews: PreviewProvider {
//    static var previews: some View {
//        TextBoxView().environmentObject(ImageEditViewModel())
//    }
//}
