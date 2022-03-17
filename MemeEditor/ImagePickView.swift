//
//  ImagePickView.swift
//  MemeEditor
//
//  Created by 范桶 on 2022/3/10.
//

import SwiftUI

struct ImagePickView: View {
    // image for ui
    @State private var image: Image?
    @ObservedObject var viewModel = ImagePickViewModel()
    
    var body: some View {
        VStack {
            Button("Choose an image from gallery") {
                viewModel.showingImagePicker = true
            }
            .accessibilityIdentifier("pickImageButton")
            .padding()
            image?
                .resizable()
                .scaledToFit()
                .padding()
                .accessibilityIdentifier("pickedImage")
        }
        .navigationTitle("Choose an image")
        .onChange(of: viewModel.inputImage) { _ in
            image = viewModel.loadImage()
        }
        .sheet(isPresented: $viewModel.showingImagePicker) {
            ImagePicker(image: $viewModel.inputImage)
        }
    }
}

struct ImagePickView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickView()
    }
}
