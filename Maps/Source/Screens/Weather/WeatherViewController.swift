//
//  Weather.swift
//  Maps
//
//  Created by Nugumanov Dmitry on 3/16/19.
//  Copyright © 2019 Nugumanov Dmitry. All rights reserved.
//

import Foundation
import UIKit

class WeatherViewController: UIViewController {
    //MARK: UIViewController lifecycle
    let serialized = NetWorker()
    
    @IBOutlet weak var tempLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        serialized.genericFetchData(byLink: Global.testWeather) { (weather: Weather?, error)  in
            if let json = weather {
                print(json.main.temp)
                self.tempLabel.text = String(json.main.tempMax)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    
}
