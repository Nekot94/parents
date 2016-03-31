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
    var coord = CLLocationCoordinate2D(latitude: 42.976, longitude: 47.502)
    var timer: NSTimer!

    @IBOutlet weak var mapView: MKMapView!{
    didSet{
        //mapView.showTraffic = false
        //mapView.nightMode = false
        mapView.showsUserLocation = true
    }
    }
    
    var me = Men()
    
    func getUserName() {
        //var name: String?
        DataService.dataService.CURRENT_USER_REF.observeEventType(.Value, withBlock: { snapshot in
            if let l = snapshot.value.valueForKey("username") as? String {
                self.me.name = l
            }
            DataService.dataService.MAN_REF.childByAppendingPath(self.me.name).observeEventType(.Value, withBlock: { snaps in

                if let p = snaps.value.valueForKey("childs")  as? [String] {
                    
                    self.me.childs = p
                    print(self.me.childs)
                }
            
                print(self.me.name)
                }, withCancelBlock: { error in
                    print(error.description)
            })
                
            
            
            }, withCancelBlock: { error in
                print(error.description)
        
        })
   
        
    }
    
    override func viewDidLoad() {
       super.viewDidLoad()
        
        self.getUserName()
        timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(MapViewController.runTimedCode), userInfo: nil, repeats: true)
        //print(me.name)
        print(UIDevice.currentDevice().identifierForVendor!.UUIDString)

    }
    
    func runTimedCode(){
        print("s")
        drawChilds()
    }
  
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }

    func getCoordinate(men: String)  {
        
        //var coordinate: CLLocationCoordinate2D?
        DataService.dataService.MAN_REF.childByAppendingPath(men).childByAppendingPath("coordinates").observeEventType(.Value, withBlock: { snapshot in
            if let l = snapshot.value.valueForKey("longitude") as? Double{
                print("longitude \(l)")
                self.coord.longitude = l
            }
            if let p = snapshot.value.valueForKey("latitude") as? Double  {
                print("latitude \(p)")
                self.coord.latitude = p
            }
            
            //let span2 = MKCoordinateSpanMake(0.01, 0.01)
            //let region2 = MKCoordinateRegion(center: self.coord, span: span2)
            //self.mapView.setRegion(region2, animated: true)
            
            let annotation2 = MKPointAnnotation()
            annotation2.coordinate = self.coord
            annotation2.title = men
            annotation2.subtitle = "Здесь"
            self.mapView.addAnnotation(annotation2)
            //print(self.coord.longitude)
            //print(self.coord.latitude)
            
            }, withCancelBlock: { error in
                print(error.description)
                
        })
        
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
        /*print(NSUserDefaults.standardUserDefaults().valueForKey("uid"))
        if NSUserDefaults.standardUserDefaults().valueForKey("uid") == nil || DataService.dataService.CURRENT_USER_REF.authData == nil {
            
            
            /*
             DataService.dataService.CURRENT_USER_REF.observeEventType(.Value, withBlock: { snapshot in
             if let l = snapshot.value.valueForKey("username") {
             print(l)
             }
             
             }, withCancelBlock: { error in
             print(error.description)
             })
             */
            NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "uid")
            
            
            let loginViewController = self.storyboard!.instantiateViewControllerWithIdentifier("Login")
            UIApplication.sharedApplication().keyWindow?.rootViewController = loginViewController
        }
        
       
        */

        //configureLocationManager()
      
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        configureLocationManager()
    }
    
    private func configureLocationManager(){
        if !CLLocationManager.locationServicesEnabled() {
            print("Location services is not enabled! Error!")
        }
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
  
        
    }

    
    //var coordinates = CLLocationCoordinate2D(latitude: 42.976, longitude: 47.502)

    func drawChilds(){
        
        if self.me.childs == []{
            return
        }
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
        
        for child in self.me.childs{
            getCoordinate(child)
            
            //let location2 =
            //let span2 = MKCoordinateSpanMake(1, 1)
            //let region2 = MKCoordinateRegion(center: location2, span: span2)
            //mapView.setRegion(region2, animated: true)
            /*
            let annotation2 = MKPointAnnotation()
            annotation2.coordinate = self.coord
            annotation2.title = child
            annotation2.subtitle = "Здесь"
            mapView.addAnnotation(annotation2)
            */
        }
        
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
        guard let identifier = segue.identifier else {
            return
        }
        switch identifier {
        case "AddChildForm":
            guard let vc = segue.destinationViewController as? AddChildViewController else {
                break
            }
            vc.me = self.me
            
        default:
            break
        }
        
   
        
 
            
    }
    
    
    
}



extension MapViewController: CLLocationManagerDelegate{
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //drawChilds()
        
        
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
