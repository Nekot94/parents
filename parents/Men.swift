//
//  Users.swift
//  parents
//
//  Created by Admin on 28.03.16.
//  Copyright © 2016 com.nekot9. All rights reserved.
//

import Foundation
import CoreLocation

class Men {
    var name = "RAmzy"
    var coordinates = CLLocationCoordinate2D(latitude: 42.976, longitude: 47.502)
    var childs: [String] = []
    init(username: String, coordinate: CLLocationCoordinate2D, child: [String]){
        name = username
        coordinates = coordinate
        childs = child
    }
    init(){
        
    }

    func addCoordinate(){
        let coordDict = ["latitude" : coordinates.latitude, "longitude": coordinates.longitude]
        DataService.dataService.writeMan(name,coordinates: coordDict)
    }
    
    func addChilds(){
        if self.childs != [] {
            DataService.dataService.writeChilds(self.name, childs: self.childs)
        }
    }
    /*
    func getCoordinate(men: String) -> CLLocationCoordinate2D? {
        
        var coordinate: CLLocationCoordinate2D?
        DataService.dataService.MAN_REF.childByAppendingPath(men).childByAppendingPath("coordinates").observeEventType(.Value, withBlock: { snapshot in
            if let l = snapshot.value.valueForKey("longitude") as? Double{
                print("longitude \(l)")
                coordinate!.longitude = l
            }
            if let p = snapshot.value.valueForKey("latitude") as? Double  {
                print("latitude \(p)")
                coordinate!.latitude = p
            }
            print(coordinate!.longitude)
            print(coordinate!.latitude)
            
            }, withCancelBlock: { error in
                print(error.description)
                
        })
        
        return coordinate
     }  
     */
    
    
    
}