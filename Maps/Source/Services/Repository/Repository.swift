//
//  Repository.swift
//  Maps
//
//  Created by Nugumanov Dmitry on 3/16/19.
//  Copyright © 2019 Nugumanov Dmitry. All rights reserved.
//

import Foundation
import RealmSwift

class Repository {
    func saveOnLocalDataBase(pins: Points) {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        let realm = try! Realm()
        
        for element in pins.pins {
            let pinID = element.id
            let realmObject = realm.objects(PinList.self).filter("id == \(pinID)")
//            print(realmObject.count)
            // save object
            if realmObject.count == 0 {
                let pointList = PinList()
                pointList.id = element.id
                pointList.specification = element.specification
                pointList.iconImage = element.iconImage
                pointList.image = element.image
                pointList.latitude = element.latitude
                pointList.longitude = element.longitude
                pointList.name = element.name
                pointList.type = element.type
                try! realm.write {
//                    print(pointList)
                    realm.add(pointList)
                }
            } else {
                 // update jbject
                let object = realmObject.first
                try! realm.write {
                    object!.id = element.id
                    object!.specification = element.specification
                    object!.iconImage = element.iconImage
                    object!.image = element.image
                    object!.latitude = element.latitude
                    object!.longitude = element.longitude
                    object!.name = element.name
                    object!.type = element.type
                }
            }
        }
    }
}
