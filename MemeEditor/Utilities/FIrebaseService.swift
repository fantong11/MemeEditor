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
    
    func signIn(email: String, password: String) {
        firebaseAuth.signIn(withEmail: email, password: password) { authResult, error in
            if error != nil {
                print(error!)
                return
            }
            
            if !authResult!.user.isEmailVerified {
                print("Email is not verified.")
                return
            }
            print("Login Success!")
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
