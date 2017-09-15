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
    dynamic var rawSex: Int
    public var sex: Sex {
        get {
            return Sex(rawValue: rawSex)!
        }
        set {
            rawSex = newValue.rawValue
        }
    }
    
    override static func ignoredProperties() -> [String] {
        return ["state"]
    }
    
    
    init(fireUid: String, email: String, firstName: String, lastName: String, age: Int, sex: Sex) {
        self.fireUid = fireUid
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.rawSex = -1
        super.init()
        self.sex = sex
    }
    
    required init() {
        self.fireUid = ""
        self.email = ""
        self.firstName = ""
        self.lastName = ""
        self.age = -1
        self.rawSex = -1
        super.init()
        self.sex = Sex.UNKNOWN
    }
    
    
    
    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        fatalError("init(realm:schema:) has not been implemented")
    }
}
