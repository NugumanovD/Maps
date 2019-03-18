//
//  PinList.swift
//  Maps
//
//  Created by Nugumanov Dmitry on 3/16/19.
//  Copyright © 2019 Nugumanov Dmitry. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class PinList: Object, Decodable {
    
    @objc dynamic var name: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var longitude: Double = 0
    @objc dynamic var latitude: Double = 0
    @objc dynamic var iconImage: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var specification: String = ""
    @objc dynamic var type: String = ""
    
    @objc dynamic var owner: Points? = nil
    
    let person = LinkingObjects(fromType: Points.self, property: "pins")
    
    //    override static func primaryKey() -> String? {
    //        return "pins"
    //    }
    
    private enum PinCodingKeys: String, CodingKey {
        case name
        case id
        case longitude
        case latitude
        case iconImage
        case image
        case specification
        case type
    }
    
    convenience init(name: String, id: Int, longitude: Double, latitude: Double, iconImage: String, image: String, specification: String, type: String) {
        self.init()
        
        self.name = name
        self.id = id
        self.longitude = longitude
        self.latitude = latitude
        self.iconImage = iconImage
        self.image = image
        self.specification = specification
        self.type = type
        
    }
    
    convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PinCodingKeys.self)
        
        let name = try container.decode(String.self, forKey: .name)
        let id = try container.decode(Int.self, forKey: .id)
        let longitude = try container.decode(Double.self, forKey: .longitude)
        let latitude = try container.decode(Double.self, forKey: .latitude)
        let iconImage = try container.decode(String.self, forKey: .iconImage)
        let image = try container.decode(String.self, forKey: .image)
        let specification = try container.decode(String.self, forKey: .specification)
        let type = try container.decode(String.self, forKey: .type)
        
        self.init(name: name, id: id, longitude: longitude, latitude: latitude, iconImage: iconImage, image: image, specification: specification, type: type)
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
