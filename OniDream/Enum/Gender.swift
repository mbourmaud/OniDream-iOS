//
//  Sex.swift
//  OniDream
//
//  Created by Martin Porrès on 15/09/2017.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

enum Gender: Int {
    case UNKNOWN = 0
    case MALE = 1
    case FEMALE = 2
    
    static func stateFromString(stateString: String) -> Gender? {
        switch stateString {
        case "male":
            return .MALE
        case "female":
            return .FEMALE
        default:
            return .UNKNOWN
        }
    }
}
