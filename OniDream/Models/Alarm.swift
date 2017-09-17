//
//  Alarm.swift
//  OniDream
//
//  Created by Mathieu Bourmaud on 2017-09-16.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import Realm
import RealmSwift

class Alarm: Object {
	dynamic var time: Date = Date()
}

