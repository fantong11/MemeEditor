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
    @State private var isShowingEditView = false
    @ObservedObject var viewModel = ViewModel()
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                Button("Choose an image from gallery") {
                    viewModel.showingImagePicker = true
                }
                .accessibilityIdentifier("pickImageButton")
                .padding()
                
                NavigationLink(destination: ImageEditView(baseImage: $viewModel.inputImage), isActive: $isShowingEditView) { EmptyView() }
                
                Button("Tap to use Doc Oct") {
                    viewModel.inputImage = UIImage(named: "hello-peter")
                    isShowingEditView = true
                }
            }
            .navigationTitle("Choose an image")
            .onChange(of: viewModel.inputImage) { _ in
                if let inputImage = viewModel.inputImage {
                    image = Image(uiImage: inputImage)
                    
                    isShowingEditView = true
                }
            }
            .sheet(isPresented: $viewModel.showingImagePicker) {
                ImagePicker(image: $viewModel.inputImage)
            }
        }
        
    }
}

struct ImagePickView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickView()
    }
}
