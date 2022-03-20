//
//  LoginViewModel.swift
//  MemeEditor
//
//  Created by 范桶 on 2022/3/19.
//

import Foundation
import FirebaseAuth

enum LoginState {
    case login
    case signin
    case resetPassword
}

class LoginViewModel: ObservableObject {
    @Published var viewState: LoginState = .login
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var checkPassword: String = ""
    
    init() {
        
    }
    
    func login() {
        print(email, password)
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            
            if error != nil {
                print(error!)
                return
            }
            
            if !Auth.auth().currentUser!.isEmailVerified {
                print("Email is not verified.")
                return
            }
        }
    }
    
    func signin() {
        print(email, password)
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
                print(error!)
                return
            }
            
            Auth.auth().currentUser?.sendEmailVerification(completion: { error in
                if error != nil {
                    print(error!)
                }
            })
            
        }
    }
    
    func resetPassword() {
        print(email)
    }
    
}
