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

//struct MyPoints: Codable, Hashable {
//    let pins: [Pin]
//    
//    enum CodingKeys: String, CodingKey {
//        case pins = "pins"
//    }
//}
//
//struct Pin: Codable, Hashable {
//    let name: String
//    let longitude: Double
//    let latitude: Double
//    let iconImage: String
//    let image: String
//    let descriprion: String
//    let type: String
//    
//    enum CodingKeys: String, CodingKey {
//        case name = "name"
//        case longitude = "longitude"
//        case latitude = "latitude"
//        case iconImage = "iconImage"
//        case image = "image"
//        case descriprion = "descriprion"
//        case type = "type"
//    }
//}

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


class PinList: Object, Decodable {
    
    @objc dynamic var name: String = ""
    @objc dynamic var longitude: Double = 0
    @objc dynamic var latitude: Double = 0
    @objc dynamic var iconImage: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var descriprion: String = ""
    @objc dynamic var type: String = ""
    
    @objc dynamic var owner: Points? = nil
    
    let person = LinkingObjects(fromType: Points.self, property: "pins")
    
    override static func primaryKey() -> String? {
        return "name"
    }
    
    private enum PinCodingKeys: String, CodingKey {
        case name
        case longitude
        case latitude
        case iconImage
        case image
        case descriprion
        case type
    }
    
    convenience init(name: String, longitude: Double, latitude: Double, iconImage: String, image: String, descriprion: String, type: String) {
        self.init()
        
        self.name = name
        self.longitude = longitude
        self.latitude = latitude
        self.iconImage = iconImage
        self.image = image
        self.descriprion = description
        self.type = type
       
    }
    
    convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PinCodingKeys.self)
        
        let name = try container.decode(String.self, forKey: .name)
        let longitude = try container.decode(Double.self, forKey: .longitude)
        let latitude = try container.decode(Double.self, forKey: .latitude)
        let iconImage = try container.decode(String.self, forKey: .iconImage)
        let image = try container.decode(String.self, forKey: .image)
        let descriprion = try container.decode(String.self, forKey: .descriprion)
        let type = try container.decode(String.self, forKey: .type)
        
        self.init(name: name, longitude: longitude, latitude: latitude, iconImage: iconImage, image: image, descriprion: descriprion, type: type)
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
