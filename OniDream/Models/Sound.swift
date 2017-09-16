//
//  Sound.swift
//  OniDream
//
//  Created by Mathieu Bourmaud on 2017-09-16.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import Realm
import RealmSwift

class Sound: Object {
	dynamic var isOn: Bool = false
	dynamic var name: String = "Waves"
	dynamic var volume: Int = 5
}
