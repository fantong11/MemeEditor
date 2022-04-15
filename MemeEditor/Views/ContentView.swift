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
                        Image(systemName: "house")
                        Text("主頁")

                    }.tag(1)
                }
                UserView(viewModel: .init()).tabItem {
                    NavigationLink(destination: UserView(viewModel: .init())) {
                        Image(systemName: "person")
                        Text("我的")

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
