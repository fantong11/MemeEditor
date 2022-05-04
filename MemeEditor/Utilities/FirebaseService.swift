//
//  Authentication.swift
//  MemeEditor
//
//  Created by 范桶 on 2022/4/4.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class FirebaseService {
    let firebaseAuth = FirebaseAuth.Auth.auth()
    let firebaseFirestore = FirebaseFirestore.Firestore.firestore()
    
    init() {
        
    }
    
    func getCurrentUser() -> User? {
        return firebaseAuth.currentUser
    }
    
    func signIn(email: String, password: String, result: @escaping (_ error: AuthErrorCode?, _ data: String?) -> Void) {
        firebaseAuth.signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                if let errCode = AuthErrorCode(rawValue: error._code) {
                    result(errCode, nil)
                    return
                }
            }
            if let authResult = authResult {
                if !authResult.user.isEmailVerified {
                    result(nil, "Email is not verified.")
                    return
                }
            }
            result(nil, "login success")
        }
    }
    
    func signUp(email: String, password: String) {
        firebaseAuth.createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
                print(error!)
                return
            }
            
            authResult?.user.sendEmailVerification(completion: { error in
                if error != nil {
                    print(error!)
                }
            })
            
        }
    }
    
    func signOut() {
        do {
            try firebaseAuth.signOut()
        }
        catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}
