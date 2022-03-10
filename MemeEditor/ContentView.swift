//
//  ContentView.swift
//  MemeEditor
//
//  Created by 范桶 on 2022/3/5.
//

import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        VStack {
            Button("Choose an image from gallery") {
                showingImagePicker = true
            }
            .padding()
            image?
                .resizable()
                .scaledToFit()
                .padding()
        }
        .navigationTitle("Choose an image")
        .onChange(of: inputImage) { _ in
            loadImage()
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else {
            return
        }
        print(inputImage)
        image = Image(uiImage: inputImage)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
