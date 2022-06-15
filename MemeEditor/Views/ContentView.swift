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
                ImagePickView(viewModel: .init())
                    .tabItem {
                        Image(systemName: "house")
                        Text("主頁")
                    }
                UserView(viewModel: .init())
                    .tabItem {
                        Image(systemName: "person")
                        Text("我的")
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
