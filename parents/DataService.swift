//
//  DataService.swift
//  parents
//
//  Created by swift1 on 27.03.16.
//  Copyright © 2016 com.nekot9. All rights reserved.
//




import Foundation
import Firebase

class DataService {
    static let dataService = DataService()
    
    private var _BASE_REF = Firebase(url: "\(BASE_URL)")
    private var _USER_REF = Firebase(url: "\(BASE_URL)/users")
    private var _MAN_REF = Firebase(url: "\(BASE_URL)/men")
    
    var BASE_REF: Firebase {
        return _BASE_REF
    }
    
    var USER_REF: Firebase {
        return _USER_REF
    }
    
    var MAN_REF: Firebase {
        return _MAN_REF
    }
    
    var CURRENT_USER_REF: Firebase {
        let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        
        let currentUser = Firebase(url: "\(BASE_REF)").childByAppendingPath("users").childByAppendingPath(userID)
        
        return currentUser!
    }
    
    
    func createNewAccount(uid: String, user: Dictionary<String, String>) {
        
        // A User is born.
        
        USER_REF.childByAppendingPath(uid).setValue(user)
    }
    
    func writeMan(name: String, coordinates: Dictionary<String, Double> ) { //men: [String] ) {
        
    
        
            MAN_REF.childByAppendingPath(name).setValue(coordinates)
        
        }
    
}