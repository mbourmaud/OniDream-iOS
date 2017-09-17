//
//  Settings.swift
//  OniDream
//
//  Created by Mathieu Bourmaud on 2017-09-16.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import Realm
import RealmSwift

class Settings: Object {
	dynamic var sound: Sound? = Sound()
	dynamic var vibration: Vibration? = Vibration()
	dynamic var led: Led? = Led()
	dynamic var alarm: Alarm? = Alarm()
}

