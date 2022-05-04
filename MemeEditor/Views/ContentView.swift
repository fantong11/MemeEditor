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
                    Image(systemName: "car")
                    Text("Trips")
                }
                SettingView().tabItem {
                    Image(systemName: "car")
                    Text("Trips")
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
