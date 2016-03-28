//
//  MapViewController.swift
//  parents
//
//  Created by swift1 on 27.03.16.
//  Copyright © 2016 com.nekot9. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


class MapViewController: UIViewController {
    
    var locationManager = CLLocationManager()

    @IBOutlet weak var mapView: MKMapView!{
    didSet{
        //mapView.showTraffic = false
        //mapView.nightMode = false
        mapView.showsUserLocation = true
    }
    }
    
    var me = Men()
    
    func getUserName(inout name: String) {
        //var name: String?
        DataService.dataService.CURRENT_USER_REF.observeEventType(.Value, withBlock: { snapshot in
                name = snapshot.value.valueForKey("username") as! String
                print(name)
            
            }, withCancelBlock: { error in
                print(error.description)
        
        })
   
        
    }
    
    override func viewDidLoad() {
       super.viewDidLoad()
        
        getUserName(&me.name)
        print(me.name)
        
        print(UIDevice.currentDevice().identifierForVendor!.UUIDString)
        /*let location = CLLocationCoordinate2D(
            latitude: 51.50007773,
            longitude: -0.1246402
        )
        // 2
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        
        
        //3
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Big Ben"
        annotation.subtitle = "London"
        mapView.addAnnotation(annotation)
        
    
        let location2 = self.coordinates        // 2
        let span2 = MKCoordinateSpanMake(1, 1)
        let region2 = MKCoordinateRegion(center: location2, span: span2)
        mapView.setRegion(region2, animated: true)
        
        let annotation2 = MKPointAnnotation()
        annotation2.coordinate = location2
        annotation2.title = "Me"
        annotation2.subtitle = "Here"
        mapView.addAnnotation(annotation2) */
    }
    

  
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

  
    
    @IBAction func logout(sender: AnyObject) {
        
        // unauth() is the logout method for the current user.
        
        DataService.dataService.CURRENT_USER_REF.unauth()
        
        // Remove the user's uid from storage.
        
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "uid")
        
        // Head back to Login!
        
        let loginViewController = self.storyboard!.instantiateViewControllerWithIdentifier("Login")
        UIApplication.sharedApplication().keyWindow?.rootViewController = loginViewController
    }

    
    
    override func viewWillAppear(animated: Bool) {
       
        super.viewWillAppear(animated)
       
        configureLocationManager()
      
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func configureLocationManager(){
        if !CLLocationManager.locationServicesEnabled() {
            print("Location services is not enabled! Error!")
        }
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
  
        
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    
    //var coordinates = CLLocationCoordinate2D(latitude: 42.976, longitude: 47.502)

    
    
}



extension MapViewController: CLLocationManagerDelegate{
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print(locations.last?.coordinate)
        
        let coordinates = CLLocationCoordinate2D(latitude: 42.976, longitude: 47.502)
        
        me.coordinates = locations.last?.coordinate ?? coordinates
        
        me.addCoordinate()
        
        guard !locations.isEmpty else { return }
        mapView.setCenterCoordinate(locations.last!.coordinate, animated: true)
        
        
        //mapView.showsUserLocation = true
        
        
        
        //let coordinates = CLLocationCoordinate2D(latitude: 42.976, longitude: 47.502)
        
        
        //locations.last!.coordinate.latitude = 42.976
        //locations.last!.coordinate.longitude = 47.502
        //let coordinates = CLLocationCoordinate2D(latitude: 21.282778, longitude: -157.829444)
        //let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinates,                                                                                      2000.0, 2000.0)
        
        //mapView.setRegion(coordinateRegion, animated: true)
        //self.coordinates = locations.last!.coordinate
        
    
        
        /*
        let location2 = self.coordinates        // 2
        let span2 = MKCoordinateSpanMake(1, 1)
        let region2 = MKCoordinateRegion(center: location2, span: span2)
        mapView.setRegion(region2, animated: true)
        
        let annotation2 = MKPointAnnotation()
        annotation2.coordinate = location2
        annotation2.title = "Я"
        annotation2.subtitle = "Здесь"
        mapView.addAnnotation(annotation2)
        */

    }
}
