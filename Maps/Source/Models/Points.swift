//
//  Points.swift
//  Maps
//
//  Created by Evgeniy Opryshko on 10/03/2019.
//  Copyright © 2019 Nugumanov Dmitry. All rights reserved.
//

import Foundation

struct MyPoints: Codable {
	let rock, theatre: Rock
	let wc: Wc
}

struct Rock: Codable {
	let array: [RockArray]
	
	enum CodingKeys: String, CodingKey {
		case array = "Array"
	}
}

struct RockArray: Codable {
	let description, image, latitude, longitude: String
	let preDescription: String?
	let titel: String
	
	enum CodingKeys: String, CodingKey {
		case description, image, latitude, longitude
		case preDescription = "pre-description"
		case titel
	}
}

struct Wc: Codable {
	let array: [WcArray]
	
	enum CodingKeys: String, CodingKey {
		case array = "Array"
	}
}

struct WcArray: Codable {
	let latitude, longitude: String
}
