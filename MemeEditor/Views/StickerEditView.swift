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
                if !viewModel.stickers.isEmpty {
                    Image(viewModel.stickers[viewModel.stickerEditIndex].name)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100 * viewModel.stickers[viewModel.stickerEditIndex].scale)
                        .opacity(viewModel.stickers[viewModel.stickerEditIndex].opacity)
                        .rotationEffect(.degrees(viewModel.stickers[viewModel.stickerEditIndex].rotation))
                        .frame(height: 300)
                    Spacer()
                    Group {
                        VStack(alignment: .leading) {
                            Text("Scale: \(viewModel.stickers[viewModel.stickerEditIndex].scale, specifier: "%.1f")x")
                            Slider(value: $viewModel.stickers[viewModel.stickerEditIndex].scale, in: 0.2...3)
                            Text("Rotation: \(viewModel.stickers[viewModel.stickerEditIndex].rotation, specifier: "%.0f")°")
                            Slider(value: $viewModel.stickers[viewModel.stickerEditIndex].rotation, in: 0...360)
                            Text("Opacity: \(viewModel.stickers[viewModel.stickerEditIndex].opacity * 100, specifier: "%.0f")%")
                            Slider(value: $viewModel.stickers[viewModel.stickerEditIndex].opacity, in: 0.1...1)
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
                            viewModel.removeSticker(viewModel.stickers[viewModel.stickerEditIndex])
                        }
                        .foregroundColor(.red)
                    }
                }
            }
        }
    }
}

struct StickerEditView_Previews: PreviewProvider {
    static var previews: some View {
        StickerEditView()
    }
}
