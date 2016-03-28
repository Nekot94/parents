//
//  RestoreViewController.swift
//  parents
//
//  Created by swift1 on 27.03.16.
//  Copyright © 2016 com.nekot9. All rights reserved.
//

import UIKit
import Firebase

class RestoreViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func restore(sender: AnyObject) {
        
        let email = emailField.text
    
        
        if  email != "" {
            
            // Set Email and Password for the New User.
            
            DataService.dataService.BASE_REF.resetPasswordForUser(email, withCompletionBlock: { error in
                if error != nil {
                
                // There was a problem.
                self.signupErrorAlert("Упм!", message: "У тебя проблемки")
                
                } else {
                    self.signupErrorAlert("Ура", message: "Сменили пароль. Проверь почту")
                }

            })
            
            }
            
        }
    
    @IBAction func cancelCreateAccount(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
        
    }
    
    func signupErrorAlert(title: String, message: String) {
                
                // Called upon signup error to let the user know signup didn't work.
                
                let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
                let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
                alert.addAction(action)
                presentViewController(alert, animated: true, completion: nil)
            }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
