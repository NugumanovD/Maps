//
//  MapViewController.swift
//  MapGuide
//
//  Created by Nugumanov Dmitry on 2/13/19.
//  Copyright © 2019 Nugumanov Dmitry. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation
import RealmSwift

class MapViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var googleMaps: GMSMapView!
    
    private var infoWindow = MapMarkerWindow()
    fileprivate var locationMarker: GMSMarker? = GMSMarker()
    var locationManager = CLLocationManager()
    
    var realm = try! Realm() // Access to base
    var items: Results<PinList>! // Access to model
    
     override func viewDidLoad() {
        super.viewDidLoad()
        
        items = realm.objects(PinList.self)
        
        self.infoWindow = loadNib()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
        
        let camera = GMSCameraPosition.camera(withLatitude: 47.824952, longitude: 35.090359, zoom: 13)
        
        self.googleMaps.camera = camera
        self.googleMaps.delegate = self
        self.googleMaps.isMyLocationEnabled = true
        self.googleMaps.settings.myLocationButton = true
        self.googleMaps.settings.compassButton = true
        self.googleMaps.settings.zoomGestures = true
        
        
        setupPinsOnMapView()
        
        print("This is my model \(items.count)")
    }
    
    func setupPinsOnMapView() {
        DispatchQueue.main.async {
            
            for pin in self.items {
                
                DispatchQueue.main.async {
                    
                    let marker = GMSMarker()
                    marker.position = CLLocationCoordinate2D(latitude: pin.latitude, longitude: pin.longitude)
                    
                    switch pin.type {
                    case "rest":
                        marker.icon = UIImage(named: "store")
                    case "rent":
                        marker.icon = UIImage(named: "settings")
                    default:
                        marker.icon = UIImage(named: "settings")
                    }
                    
                    marker.map = self.googleMaps
                }
            }
        }
        
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        let location: CLLocation? = googleMaps.myLocation
        
        if location != nil {
            googleMaps.animate(toLocation: (location?.coordinate)!)
        }
        return true
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        
        let infoWindow = Bundle.main.loadNibNamed("MapMarkerWindowView", owner: self.googleMaps, options: nil)?.first as! MapMarkerWindow
        
        marker.infoWindowAnchor = CGPoint(x: 0.5, y: 0.5)
        
                for name in items {
                    if marker.position.latitude == name.latitude && marker.position.longitude == name.longitude {
                        infoWindow.titleMarkerLabel.text = name.name
                        infoWindow.descriptionMarkerLabel.text = name.specification
                    }
                }
        return infoWindow
    }
    
    func loadNib() -> MapMarkerWindow {
        let infoWindow = MapMarkerWindow.instanceFromNib() as! MapMarkerWindow
        return infoWindow
    }
    // MARK: GMSMapViewDelegate
    
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("You tapped at \(coordinate.longitude), \(coordinate.latitude)")
    }
    
    
    
    
}

