//
//  UserViewModel.swift
//  MemeEditor
//
//  Created by 范桶 on 2022/4/16.
//

import Foundation

enum LoginSelect {
    case signIn
    case signUp
}

final class UserViewModel: ObservableObject {
    @Published var showLoginView = false
    var signInOrSignUp: LoginSelect = .signIn
    
}
