//
//  MemeEditorApp.swift
//  MemeEditor
//
//  Created by 范桶 on 2022/3/5.
//

import SwiftUI
@_implementationOnly import Firebase

@main
struct MemeEditorApp: App {
    
    // 在configure前面宣告會爆炸
    let firebaseService: FirebaseService
    
    init() {
        FirebaseApp.configure()
        firebaseService = FirebaseService()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
