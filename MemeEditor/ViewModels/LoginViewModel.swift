//
//  LoginViewModel.swift
//  MemeEditor
//
//  Created by 范桶 on 2022/3/19.
//

import Foundation
import FirebaseAuth

class LoginViewModel: ObservableObject {
//    @Published var state: LoginViewState
    @Published var viewState: LoginState = .signIn
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var comfirmPassword: String = ""
    var firebaseService = FirebaseService()
    
//    init(initState: LoginViewState) {
//        self.state = initState
//    }
    
    func signIn() {
        firebaseService.signIn(email: email, password: password)
    }
    
    func signUp() {
        firebaseService.signUp(email: email, password: password)
    }
    
    func resetPassword() {
        print(email)
    }
    
}
