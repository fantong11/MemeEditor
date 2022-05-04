//
//  UserViewModel.swift
//  MemeEditor
//
//  Created by 范桶 on 2022/4/16.
//

import Foundation
@_implementationOnly import FirebaseAuth

enum LoginSelect {
    case signIn
    case signUp
}

final class UserViewModel: ObservableObject {
    @Published var showLoginView = false
    @Published var currentUser: User?
    let firebaseService = FirebaseService()
    var signInOrSignUp: LoginSelect = .signIn
    
    init() {
        firebaseService.firebaseAuth.addStateDidChangeListener { auth, user in
            self.currentUser = user
        }
    }
    
    func getCurrentUser() -> User? {
        return firebaseService.getCurrentUser()
    }
    
    func signOut() {
        firebaseService.signOut()
    }
}
