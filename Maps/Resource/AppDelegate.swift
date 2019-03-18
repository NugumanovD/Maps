//
//  AppDelegate.swift
//  Maps
//
//  Created by Nugumanov Dmitry on 3/7/19.
//  Copyright © 2019 Nugumanov Dmitry. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import RealmSwift
import Realm

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    let placesAPIKey = "AIzaSyCMs9HduByFIyK9tKoPz9xuIxbuEIOWp8A"
    let serializer = NetWorker()
    let repository = Repository()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        GMSServices.provideAPIKey(placesAPIKey)
        GMSPlacesClient.provideAPIKey(placesAPIKey)
        loadDataBase()
        //        UITabBar.appearance().tintColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        loadDataBase()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func loadDataBase() {
//        serializer.fetchData(byLink: Global.mapMarkers) { (pins, error) in
//            if let mapPins = pins {
////                print(mapPins)
//                self.repository.saveOnLocalDataBase(pins: mapPins)
//            }
//        }
        serializer.genericFetchData(byLink: Global.mapMarkers) { (pins: Points? , error) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let mapPins = pins {
                print(mapPins)
                self.repository.saveOnLocalDataBase(pins: mapPins)
            }
        }
    }
    
    
    
    
}


