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

    public func login(email: String, password: String, auth: Auth, completion: AuthResultCallback?) {
		auth.signIn(withEmail: email, password: password, completion: completion)
    }
    
    public func signup(email: String, password: String, auth: Auth, completion: AuthResultCallback?) {
        auth.createUser(withEmail: email, password: password, completion: completion)
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
