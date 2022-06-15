//
//  AddTextBoxView.swift
//  MemeEditor
//
//  Created by 范桶 on 2022/5/2.
//

import SwiftUI

struct AddTextBoxView: View {
    @EnvironmentObject var viewModel: ImageEditViewModel
    @FocusState var isTextBoxFocused: Bool
    
    var body: some View {
        Color.black
            .opacity(0.5)
            .ignoresSafeArea()
//        let _ = print("\(viewModel.currentIndex), \(viewModel.textBoxes.count)")
        if !viewModel.creation.textBoxList.textBoxes.isEmpty {
            TextField("Type Here", text: $viewModel.creation.textBoxList.textBoxes[viewModel.creation.textBoxList.currentIndex].text)
                .font(.system(size: 35, weight: viewModel.creation.textBoxList.textBoxes[viewModel.creation.textBoxList.currentIndex].isBold ? .bold : .regular))
                .foregroundColor(viewModel.creation.textBoxList.textBoxes[viewModel.creation.textBoxList.currentIndex].textColor)
                .padding()
                .preferredColorScheme(.dark)
                .focused($isTextBoxFocused)
            HStack {
                Button {
                    viewModel.addTextBox()
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
                    ColorPicker("Set the text color", selection: $viewModel.creation.textBoxList.textBoxes[viewModel.creation.textBoxList.currentIndex].textColor)
                        .labelsHidden()
                    Button {
                        viewModel.creation.textBoxList.textBoxes[viewModel.creation.textBoxList.currentIndex].isBold.toggle()
                    } label: {
                        Text(viewModel.creation.textBoxList.textBoxes[viewModel.creation.textBoxList.currentIndex].isBold ? "Normal" : "Bold")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                }
            }
            .padding()
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}

struct AddTextBoxView_Previews: PreviewProvider {
    static var previews: some View {
        AddTextBoxView()
            .environmentObject(ImageEditViewModel(creation: Creation.sampleData[0]))
    }
}
