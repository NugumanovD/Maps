//
//  NetWorker.swift
//  Maps
//
//  Created by Evgeniy Opryshko on 10/03/2019.
//  Copyright © 2019 Nugumanov Dmitry. All rights reserved.
//

import Foundation

class NetWorker {
	
	func getData() {
		guard let gitUrl = URL(string: Global.url) else { return }
		URLSession.shared.dataTask(with: gitUrl) { (data, response
			, error) in
			guard let data = data else { return }
			do {
				let decoder = JSONDecoder()
				let gitData = try decoder.decode(MyPoints.self, from: data)
				print(gitData.rock.array)
				
			} catch let err {
				print("Err", err)
			}
			}
			.resume()
	}
}
