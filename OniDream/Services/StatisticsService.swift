//
//  StatisticsService.swift
//  OniDream
//
//  Created by Martin Porrès on 17/09/2017.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import Realm

class StatisticsService {
    let realm = try! Realm()
    
    // Can't init is singleton
    private init() { }
    
    // MARK: Shared Instance
    
    static let shared = StatisticsService()
    
    public func saveStatistics(statistics: Statistics) {
        realm.add(statistics)
    }
    
    func loadStatistics() -> Results<Statistics>? {
            return realm.objects(Statistics.self)
    }
}

