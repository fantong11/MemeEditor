//
//  MemeEditorApp.swift
//  MemeEditor
//
//  Created by 范桶 on 2022/3/5.
//

import SwiftUI
import Firebase

@main
struct MemeEditorApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ImagePickView()
        }
    }
}
