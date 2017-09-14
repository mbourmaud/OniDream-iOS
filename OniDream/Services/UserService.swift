//
//  UserService.swift
//  OniDream
//
//  Created by Martin Porrès on 14/09/2017.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import Foundation
import Firebase

class UserService {
    
    // Can't init is singleton
    private init() { }
    
    // MARK: Shared Instance
    
    static let shared = UserService()
    
    public func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error == nil {
                ModalController.shared.showModal(title: "Success", message: "You are now logged in", type: .success)
            } else {
                ModalController.shared.showModal(title: "Error", message: "Invalid login or password", type: .error)
            }
        }
    }
}
