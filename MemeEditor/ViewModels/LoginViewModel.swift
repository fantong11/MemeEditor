//
//  LoginViewModel.swift
//  MemeEditor
//
//  Created by 范桶 on 2022/3/19.
//

import Foundation
import FirebaseAuth

final class LoginViewModel: StateBindingViewModel<LoginViewState> {
    
    let firebaseService: FirebaseService = FirebaseService()

    func signIn() {
        firebaseService.signIn(email: state.email, password: state.password)
    }
    
    func signUp() {
        firebaseService.signUp(email: state.email, password: state.password)
    }
    
    func resetPassword() {
        print(state.email)
    }
    
}
