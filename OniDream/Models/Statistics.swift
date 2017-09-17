//
//  Statistics.swift
//  OniDream
//
//  Created by Martin Porrès on 17/09/2017.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import Realm

class Statistics {
    dynamic var sleepTime: [Double]
    dynamic var sleepQuality: [[String: Double]]
	
    init(sleepTime: [Double], sleepQuality: [[String: Double]]) {
        self.sleepTime = sleepTime
        self.sleepQuality = sleepQuality
	}
    
    required init() {
        self.sleepTime = []
        self.sleepQuality = [[String: Double]]()
	}
    
    /*required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        fatalError("init(realm:schema:) has not been implemented")
    }*/
}
