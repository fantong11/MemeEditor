//
//  LoginViewModel.swift
//  MemeEditor
//
//  Created by 范桶 on 2022/3/19.
//

import Foundation
import SwiftUI
@_implementationOnly import FirebaseAuth

final class LoginViewModel: StateBindingViewModel<LoginViewState> {
    let firebaseService: FirebaseService = FirebaseService()
    @Binding var isPresented: Bool
    
    init(initialState: LoginViewState, isPresented: Binding<Bool>) {
        self._isPresented = isPresented
        super.init(initialState: initialState)
    }
    
    func signIn() {
        firebaseService.signIn(email: state.email, password: state.password) { errorCode, data in
            if let errorCode = errorCode {
                self.state.loginError = errorCode
                return
            }
            print(data ?? "nil")
            self.isPresented = false
        }
    }
    
    func signUp() {
        firebaseService.signUp(email: state.email, password: state.password)
    }
    
    func resetPassword() {
        print(state.email)
    }
    
}
