//
//  Points.swift
//  Maps
//
//  Created by Evgeniy Opryshko on 10/03/2019.
//  Copyright © 2019 Nugumanov Dmitry. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class Points: Object, Decodable {
    
    var pins = List<PinList>()
    
    private enum PinCodingKeys: String, CodingKey {
        case pins
    }
    
    convenience init(pins: List<PinList>) {
        self.init()
        self.pins = pins
    }
    
    convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PinCodingKeys.self)
        
        let pinsArray = try container.decode([PinList].self, forKey: .pins)
        let pinsList = List<PinList>()
        pinsList.append(objectsIn: pinsArray)
        self.init(pins: pinsList)
    }
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
}



