//
//  AddChildViewController.swift
//  parents
//
//  Created by swift1 on 27.03.16.
//  Copyright © 2016 com.nekot9. All rights reserved.
//

import UIKit


class AddChildViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet weak var textMen: UITextField!
    @IBOutlet weak var delBut: UIButton!
   
    var me = Men()
    var picker = UIPickerView()

    @IBAction func delMen(sender: AnyObject) {
        
        let username2 = textMen.text
        
        if username2 == "" { return }
        
        me.removeChild(username2!)
        textMen.text = ""
        self.performSegueWithIdentifier("MapCntrollerAdd", sender: nil)
        
        
        
    }
    @IBOutlet weak var manEdit: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        textMen.hidden = false
        delBut.hidden = false
        picker.delegate = self
        picker.dataSource = self
        textMen.inputView = picker
        if me.childs.count == 0{
            textMen.hidden = true
            delBut.hidden = true
            
        } else {
            textMen.text = me.childs[0]
        }
        
   
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }
    
  
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
 
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return me.childs.count
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        textMen.text = me.childs[row]
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return me.childs[row]
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
                            self.manEdit.text = ""
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
