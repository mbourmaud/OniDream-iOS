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
	dynamic var title: String
	dynamic var content: String
	dynamic var date: Date
	
	init(title: String, content: String, date: Date = Date()) {
		self.title = title
		self.content = content
		self.date = date
		
		super.init()
	}
	
	required init() {
		fatalError("init() has not been implemented")
	}
	
	required init(value: Any, schema: RLMSchema) {
		fatalError("init(value:schema:) has not been implemented")
	}
	
	required init(realm: RLMRealm, schema: RLMObjectSchema) {
		fatalError("init(realm:schema:) has not been implemented")
	}
}
