//
//  SavePoints.swift
//  Maps
//
//  Created by Evgeniy Opryshko on 10/03/2019.
//  Copyright © 2019 Nugumanov Dmitry. All rights reserved.
//

import Foundation
import RealmSwift

class RealmWorker {
	
	func saveRealmArray(_ objects: [Object]) {
		let realm = try! Realm()
		print(realm.configuration.fileURL?.absoluteString ?? "")
		try! realm.write {
			realm.add(objects)
		}
	}
	
}
