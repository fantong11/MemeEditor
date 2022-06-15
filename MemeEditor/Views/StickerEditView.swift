//
//  StickerEditView.swift
//  MemeEditor
//
//  Created by Ian Liu on 6/15/22.
//

import SwiftUI

struct StickerEditView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: ImageEditViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                if !viewModel.creation.stickerList.stickers.isEmpty {
                    Image(viewModel.creation.stickerList.stickers[viewModel.creation.stickerList.editIndex].name)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100 * viewModel.creation.stickerList.stickers[viewModel.creation.stickerList.editIndex].scale)
                        .opacity(viewModel.creation.stickerList.stickers[viewModel.creation.stickerList.editIndex].opacity)
                        .rotationEffect(.degrees(viewModel.creation.stickerList.stickers[viewModel.creation.stickerList.editIndex].rotation))
                        .frame(height: 300)
                    Spacer()
                    Group {
                        VStack(alignment: .leading) {
                            Text("Scale: \(viewModel.creation.stickerList.stickers[viewModel.creation.stickerList.editIndex].scale, specifier: "%.1f")x")
                            Slider(value: $viewModel.creation.stickerList.stickers[viewModel.creation.stickerList.editIndex].scale, in: 0.2...3)
                            Text("Rotation: \(viewModel.creation.stickerList.stickers[viewModel.creation.stickerList.editIndex].rotation, specifier: "%.0f")°")
                            Slider(value: $viewModel.creation.stickerList.stickers[viewModel.creation.stickerList.editIndex].rotation, in: 0...360)
                            Text("Opacity: \(viewModel.creation.stickerList.stickers[viewModel.creation.stickerList.editIndex].opacity * 100, specifier: "%.0f")%")
                            Slider(value: $viewModel.creation.stickerList.stickers[viewModel.creation.stickerList.editIndex].opacity, in: 0.1...1)
                        }
                        Spacer()
                        Button("Done") {
                            dismiss()
                        }
                    }
                    .padding([.leading, .trailing])
                    .buttonStyle(RoundedRectangleButtonStyle())
                    .navigationTitle("Edit Sticker")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        Button("Remove Sticker", role: .destructive) {
                            viewModel.removeSticker(viewModel.creation.stickerList.stickers[viewModel.creation.stickerList.editIndex])
                        }
                        .foregroundColor(.red)
                    }
                }
            }
        }
    }
}

//struct StickerEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        StickerEditView()
//    }
//}
