//
//  ContentView.swift
//  MemeEditor
//
//  Created by 范桶 on 2022/3/5.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            TabView {
                ImagePickView().tabItem {
                    NavigationLink(destination: ImagePickView()) {
                        Image(systemName: "car")
                        Text("Trips")

                    }.tag(1)
                }
                SettingView().tabItem {
                    NavigationLink(destination: SettingView()) {
                        Image(systemName: "car")
                        Text("Trips")

                    }.tag(2)
                }
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
