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
    @StateObject var viewModel: ImagePickViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                if (!viewModel.creations.isEmpty) {
                    NavigationLink(destination: ImageEditView().environmentObject(ImageEditViewModel(creation: viewModel.creations.last!)), isActive: $isShowingEditView) {
                            EmptyView()
                        
                    }
                }
                
                if viewModel.creations.isEmpty {
                    Button("Choose an image from gallery") {
                        viewModel.isInputing = true
                    }
                    .accessibilityIdentifier("pickImageButton")
                    .padding()
                }
                else {
                    List {
                        ForEach($viewModel.creations) { $creation in
                            NavigationLink(destination: ImageEditView().environmentObject(ImageEditViewModel(creation: $creation.wrappedValue))) {
                                Text(creation.name)
                            }
                        }
                        .onDelete(perform: viewModel.deleteCreation)
                    }
                    .navigationTitle("Creations")
                    .toolbar {
                        Button(action: {
                            viewModel.isInputing = true
                            
                        }) {
                            Image(systemName: "plus")
                        }
                        .accessibilityLabel("New Creation")
                    }
                }
            }
            .onChange(of: viewModel.inputImage) { _ in
                viewModel.addCreation(creation: Creation(name: viewModel.tempName, image: viewModel.inputImage))
                isShowingEditView = true
            }
            .textFieldAlert(isPresented: $viewModel.isInputing, title: "Enter the Creation name") { name in
                if let name = name {
                    viewModel.tempName = name
                    viewModel.showingImagePicker = true
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
        Group {
            ImagePickView(viewModel: .init())
            ImagePickView(viewModel: .init(creations: Creation.sampleData))
        }
    }
}
