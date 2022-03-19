//
//  LoginViewModel.swift
//  MemeEditor
//
//  Created by 范桶 on 2022/3/19.
//

import Foundation

enum LoginState {
    case login
    case signin
    case resetPassword
}

class LoginViewModel: ObservableObject {
    @Published var viewState: LoginState
    
    init() {
        viewState = .login
    }
}
