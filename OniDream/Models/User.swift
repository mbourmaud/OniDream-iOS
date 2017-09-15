//
//  User.swift
//  OniDream
//
//  Created by Martin Porrès on 15/09/2017.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class User: Object {
    dynamic var fireUid: String
    dynamic var email: String
    dynamic var firstName: String
    dynamic var lastName: String
    dynamic var age: Int
    dynamic var rawGender: Int
    public var gender: Gender {
        get {
            return Gender(rawValue: rawGender)!
        }
        set {
            rawGender = newValue.rawValue
        }
    }
    
    override static func ignoredProperties() -> [String] {
        return ["state"]
    }
    
    
    init(fireUid: String, email: String, firstName: String, lastName: String, age: Int, gender: Gender) {
        self.fireUid = fireUid
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.rawGender = -1
        super.init()
        self.gender = gender
    }
    
    required init() {
        self.fireUid = ""
        self.email = ""
        self.firstName = ""
        self.lastName = ""
        self.age = -1
        self.rawGender = -1
        super.init()
        self.gender = Gender.UNKNOWN
    }
    
    
    
    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        fatalError("init(realm:schema:) has not been implemented")
    }
}
