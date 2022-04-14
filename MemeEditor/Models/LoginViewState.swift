//
//  User.swift
//  MemeEditor
//
//  Created by 范桶 on 2022/4/4.
//

import Foundation

enum LoginState {
    case signIn
    case signUp
    case resetPassword
}

struct LoginViewState: Equatable {
    var viewState: LoginState = .signIn
    var username: String = ""
    var email: String = ""
    var password: String = ""
    var comfirmPassword: String = ""
    var passwordError: String?
}
