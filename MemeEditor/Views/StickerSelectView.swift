//
//  StickerSelectView.swift
//  MemeEditor
//
//  Created by Ian Liu on 6/14/22.
//

import SwiftUI

struct StickerSelectView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: ImageEditViewModel
    
    let columns = [
        GridItem(.adaptive(minimum: 100), spacing: 10)
    ]
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(1..<19) { i in
                        Button {
                            let sticker = Sticker(name: "sticker\(i)")
                            viewModel.addSticker(sticker)
                            dismiss()
                        } label: {
                            Image("sticker\(i)")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                        }
                    }
                }
            }
            .navigationTitle("Stickers")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("cancel") {
                    dismiss()
                }
            }
        }
    }
}

//struct StickerSelectView_Previews: PreviewProvider {
//    static var previews: some View {
//        StickerSelectView()
//            .previewInterfaceOrientation(.portrait)
//    }
//}
