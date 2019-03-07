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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    let placesAPIKey = "AIzaSyCMs9HduByFIyK9tKoPz9xuIxbuEIOWp8A"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        GMSServices.provideAPIKey(placesAPIKey)
        GMSPlacesClient.provideAPIKey(placesAPIKey)
        //        UITabBar.appearance().tintColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        
        
        if !UserDefaults.standard.bool(forKey: "db_install") {
            self.loadDataBase()
        }
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
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func loadDataBase() {
        //создаем объекты категорий
        let restaurant = Category.getCategoryObject(
            id: 0,
            name: "restaurant",
            iconImage: "")
        
        let categories = [restaurant]
        
        //создаем объекты стройний на карте
        
        let pektoralHotel = StateModel.getStateObject(
            id: 0,
            name: "Пектораль",
            latitude: 47.8171141648544,
            longitute: 35.088985562324524,
            categories: [restaurant])
        
        let horticaHotel = StateModel.getStateObject(
            id: 1,
            name: "Хортица",
            latitude: 47.8205721644365,
            longitute: 35.09705364704132,
            categories: [restaurant])
        
        let sagaidachniyHotel = StateModel.getStateObject(
            id: 2,
            name: "Сагайдачный",
            latitude: 47.824952,
            longitute: 35.090359,
            categories: [restaurant])
        
        let members = [pektoralHotel, horticaHotel, sagaidachniyHotel]
        
        //сохраняем наши объекты в хранилище
        
        let realmInstance = try! Realm()
        try! realmInstance.write {
            for category in categories {
                realmInstance.add(category)
            }
            for member in members {
                realmInstance.add(member)
            }
        }
        
        //помечаем в Defaults что БД была установлена
        UserDefaults.standard.set(
            true,
            forKey: "db_install"
        )
    }
    
    
    
    
}


