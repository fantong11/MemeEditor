//
//  StickerView.swift
//  MemeEditor
//
//  Created by Ian Liu on 6/15/22.
//

import SwiftUI

struct StickerView: View {
    @EnvironmentObject var viewModel: ImageEditViewModel
    let sticker: Sticker
    
    var body: some View {
        Image(sticker.name)
            .resizable()
            .scaledToFit()
            .frame(width: 100 * sticker.scale)
            .opacity(sticker.opacity)
            .rotationEffect(.degrees(sticker.rotation))
            .offset(sticker.offset)
            .gesture(DragGesture()
                .onChanged { value in
                    let current = value.translation
                    let last = sticker.lastOffset
                    let newTranslation = CGSize(width: last.width + current.width, height: last.height + current.height)
                    viewModel.creation.stickerList.stickers[viewModel.getIndex(of: sticker)].offset = newTranslation
                }.onEnded { value in
                    viewModel.creation.stickerList.stickers[viewModel.getIndex(of: sticker)].lastOffset = value.translation
                }
            )
            .gesture(LongPressGesture()
                .onEnded{ _ in
                    viewModel.creation.stickerList.editIndex = viewModel.getIndex(of: sticker)
                    viewModel.isShowingEditSheet = true
                }
            )
    }
}

struct StickerView_Previews: PreviewProvider {
    static var previews: some View {
        StickerView(sticker: Sticker(name: "sticker1"))
    }
}
