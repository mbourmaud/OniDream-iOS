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

class Statistics: Object {
    dynamic var sleepTime: [Double]
    dynamic var sleepQuality: [[String: Double]]
    
    init(sleepTime: [Double], sleepQuality: [[String: Double]]) {
        self.sleepTime = sleepTime
        self.sleepQuality = sleepQuality
        
        super.init()
    }
    
    required init() {
        self.sleepTime = []
        self.sleepQuality = [[String: Double]]()
        
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        fatalError("init(realm:schema:) has not been implemented")
    }
}
//class Statistics: NSObject, NSCoding {
//    var sleepTime : [Double] = [];
//    var sleepQuality : [[String: Double]] = [[String: Double]]();
//
//
//    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
//
//    init(sleepTime: [Double], sleepQuality: [[String: Double]]) {
//        self.sleepQuality = sleepQuality
//        self.sleepTime = sleepTime
//    }
//
//    convenience override init () {
//        self.init(sleepTime: [], sleepQuality: [[:]])
//    }
//
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(sleepTime, forKey: PropertyKey.sleepTimeKey)
//        aCoder.encode(sleepQuality, forKey: PropertyKey.sleepQualityKey)
//    }
//
//    required convenience init?(coder aDecoder: NSCoder) {
//        let sleepTime = aDecoder.decodeObject(forKey: PropertyKey.sleepTimeKey) as! [Double]
//        let sleepQuality = aDecoder.decodeObject(forKey: PropertyKey.sleepQualityKey) as! [[String: Double]]
//        self.init(sleepTime: sleepTime, sleepQuality: sleepQuality)
//    }
//
//    struct PropertyKey {
//        static let  sleepTimeKey = "sleepTime"
//        static let  sleepQualityKey = "sleepQuality"
//    }
//}

