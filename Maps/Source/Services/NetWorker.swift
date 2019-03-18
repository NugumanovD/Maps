//
//  NetWorker.swift
//  Maps
//
//  Created by Evgeniy Opryshko on 10/03/2019.
//  Copyright © 2019 Nugumanov Dmitry. All rights reserved.
//

import Foundation
import RealmSwift

class NetWorker {
    
    func fetchData(byLink: String, complation: @escaping (Points?, Error?) -> Void) {
        
        let session = URLSession(configuration: .default)
        guard let url = URL(string: byLink) else {
            complation(nil, nil)
            return
        }
        
        let task = session.dataTask(with: url) { (data, _, error) in
            if let error = error {
                complation(nil, error)
                print(error.localizedDescription)
                return
            }
            guard let data = data,
                let json = try? JSONDecoder().decode(Points.self, from: data) else {
                    complation(nil, nil)
                    return
            }
            DispatchQueue.main.async {
                complation(json,nil)
            }
        }
        task.resume()
    }
    
    func genericFetchData<T>(byLink: String, complation: @escaping (T?, Error?) -> Void) where T: Decodable {
        
        let session = URLSession(configuration: .default)
        guard let url = URL(string: byLink) else {
            complation(nil, nil)
            return
        }
        
        let task = session.dataTask(with: url) { (data, _, error) in
            if let error = error {
                complation(nil, error)
                print(error.localizedDescription)
                return
            }
            guard let data = data,
                let json = try? JSONDecoder().decode(T.self, from: data) else {
                    complation(nil, nil)
                    return
            }
            DispatchQueue.main.async {
                complation(json,nil)
            }
        }
        task.resume()
    }
    
    
    
}
