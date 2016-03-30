//
//  AddChildViewController.swift
//  parents
//
//  Created by swift1 on 27.03.16.
//  Copyright © 2016 com.nekot9. All rights reserved.
//

import UIKit

class AddChildViewController: UIViewController {
    
    
    var me = Men()

    @IBOutlet weak var manEdit: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
       // print(self.me.name)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func findMan(sender: AnyObject) {
        let username = manEdit.text

        
        if username != "" {
            DataService.dataService.MAN_REF.observeEventType(.Value, withBlock: { [unowned self] snapshot in
              
                if let l = snapshot.value.valueForKey(username!) {
                    if username! != self.me.name  {
                        if !self.me.childs.contains(username!) {
                            self.me.childs.append(username!)
                            self.me.addChilds()
                            print(l)
                            self.performSegueWithIdentifier("MapCntrollerAdd", sender: nil)
                            
                        }else {
                            print("Такой человек уже есть в вашем списке")
                            //self.addErrorAlert("Оопх!", message:"Такой человек уже есть в вашем списке" )
                        }
                    } else {
                        print("Нельзя доббавить себя")
                        //self.addErrorAlert("Оопх!", message:"Нельзя доббавить себя" )
                    }
                    
                } else {
                    print("Нет такого человека")
                    //self.addErrorAlert("Оопх!", message:"Нет такого человека" )
                }
                }, withCancelBlock: { error in
                    print(error.description)
                    
            })
            
            
        }

    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        guard let identifier = segue.identifier else {
            return
        }
        switch identifier {
        case "MapCntrollerAdd":
            guard let vc = segue.destinationViewController as? MapViewController else {
                break
            }
            vc.me = self.me
           
        default:
            break
        }
    }
    
    
    func addErrorAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }

}
