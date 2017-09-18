//
//  Dream.swift
//  OniDream
//
//  Created by Mathieu Bourmaud on 2017-09-09.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import Realm
import RealmSwift

class Dream: Object {
	dynamic var title: String = ""
	dynamic var content: String = ""
	dynamic var date: Date = Date()
}
