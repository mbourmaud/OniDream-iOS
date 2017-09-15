//
//  UserService.swift
//  OniDream
//
//  Created by Martin Porrès on 14/09/2017.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import Foundation
import Firebase

final class UserService {
    
    // Can't init is singleton
    private init() { }
    
    // MARK: Shared Instance
    
    static let shared = UserService()
    
//    public func login(email: String, password: String, auth: Auth) -> Auth? {
//        var authError: Bool
//
//        let AuthResultCallback toto = auth.signIn(withEmail: email, password: password) { (user, error) in
//            if error == nil {
//                ModalController.shared.showModal(title: "Success", message: "You are now logged in", type: .success)
//                authError = false
//            } else {
//                let errorMessage = error?.localizedDescription
//                ModalController.shared.showModal(title: "Error", message: errorMessage!, type: .error)
//                authError = true
//                print("authError = true")
//            }
//            print("TEST")
//        }
//        if (authError) {
//            print("FAIIIIILLLL")
//            return nil
//        }
//        return auth
//    }
    public func login(email: String, password: String, auth: Auth, completion: AuthResultCallback? = nil) {
        auth.signIn(withEmail: email, password: password)
    }
    
    public func setCurrentUser(auth: Auth) -> User {
        let currentUser: User
        let fireUser = auth.currentUser
        
        currentUser = User()
        currentUser.fireUid = fireUser!.uid
        currentUser.email = fireUser!.email!
        return currentUser
    }
}
