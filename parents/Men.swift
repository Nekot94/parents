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
    var childs: [Men] = []
    init(username: String, coordinate: CLLocationCoordinate2D, child: [Men]){
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
    
    
}