//
//  LoginViewController.swift
//  parents
//
//  Created by swift1 on 27.03.16.
//  Copyright © 2016 com.nekot9. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // If we have the uid stored, the user is already logger in - no need to sign in again!
        //let dat = ["Longtitude": "47.5126285", "Latitude": "42.9666308"]
        //DataService.dataService.createNewMan("Fack@mail.ru", coordinates: dat)
        
        if NSUserDefaults.standardUserDefaults().valueForKey("uid") != nil && DataService.dataService.CURRENT_USER_REF.authData != nil {
            
          
            
            /*
            DataService.dataService.CURRENT_USER_REF.observeEventType(.Value, withBlock: { snapshot in
                if let l = snapshot.value.valueForKey("username") {
                    print(l)
                }
                
                }, withCancelBlock: { error in
                    print(error.description)
            })
            */
            self.performSegueWithIdentifier("CurrentlyLoggedIn", sender: nil)
        } 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func tryLogin(sender: AnyObject) {
        let email = emailField.text
        let password = passwordField.text
        
        if email != "" && password != "" {
            
            // Login with the Firebase's authUser method
            
            DataService.dataService.BASE_REF.authUser(email, password: password, withCompletionBlock: { error, authData in
                
                if error != nil {
                    print(error)
                    self.loginErrorAlert("Оопм!", message: "Проверька имя и пароль")
                } else {
                    
                    // Be sure the correct uid is stored.
                    
                    NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                    
                    // Enter the app!
                    
                    self.performSegueWithIdentifier("CurrentlyLoggedIn", sender: nil)
                }
            })
            
        } else {
            
            // There was a problem
            
            loginErrorAlert("Упм!", message: "Введи имя и пароль")
        }
        
    }
    
    func loginErrorAlert(title: String, message: String) {
        
        // Ошибки обрабатываются тут.
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
}
