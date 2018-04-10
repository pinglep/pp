//
//  AddCustomerController.swift
//  A6
//
//  Created by Pooja Pingle on 3/3/18.
//  Copyright © 2018 Pooja Pingle. All rights reserved.
//

import UIKit

class AddCustomerController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var custname: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var passportid: UITextField!
    @IBOutlet weak var phoneNum: UITextField!
    @IBOutlet weak var submitaddcust: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.custname.delegate = self
        self.address.delegate = self
        self.passportid.delegate = self
        self.phoneNum.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        custname.resignFirstResponder()
        address.resignFirstResponder()
        passportid.resignFirstResponder()
        phoneNum.resignFirstResponder()
        return (true)
    }

    @IBAction func backButtonAddCPage(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    @IBAction func addcustomer(_ sender: Any) {
        if custname!.text! == ""{
            let alertView = UIAlertView();
            alertView.addButton(withTitle: "OK");
            alertView.title = "Alert";
            alertView.message = "Please enter patients name";
            alertView.show();
        }else if address!.text! == "" {
            let alertView = UIAlertView();
            alertView.addButton(withTitle: "OK");
            alertView.title = "Alert";
            alertView.message = "Please enter address";
            alertView.show();
        }else if passportid!.text! == "" {
            let alertView = UIAlertView();
            alertView.addButton(withTitle: "OK");
            alertView.title = "Alert";
            alertView.message = "Please enter identification";
            alertView.show();
        }else if phoneNum!.text! == "" {
            let alertView = UIAlertView();
            alertView.addButton(withTitle: "OK");
            alertView.title = "Alert";
            alertView.message = "Please enter phone number";
            alertView.show();
        }else{
            if phoneNum!.text!.characters.count == 10 {
                //validate(value: phVal!.text!)
                
                let new  = isValidPhone(value :phoneNum!.text!)
                
                if new == false{
                    let alertView = UIAlertView();
                    alertView.addButton(withTitle: "OK");
                    alertView.title = "Alert";
                    alertView.message = "not valid";
                    alertView.show();
                    return;
                }else{
                    let custemp = Patients(context: context)
                    custemp.name = custname!.text!
                    custemp.address = address!.text!
                    custemp.phoneNumber = Int64(Int(phoneNum!.text!)!)
                    custemp.idNumber = passportid!.text!
                    
                    appDelegate.saveContext()
                    let alertView = UIAlertView();
                    alertView.addButton(withTitle: "OK");
                    alertView.title = "Alert";
                    alertView.message = "Patient successfully created";
                    alertView.show();
                    
                    return;
                }
                
                
            }else{
                let alertView = UIAlertView();
                alertView.addButton(withTitle: "OK");
                alertView.title = "Alert";
                alertView.message = "Not a valid number";
                alertView.show();
                return;
                
            }
        }
    }
    func isValidPhone(value: String) -> Bool {
        
        let PHONE_REGEX = "^[0-9]{10}$"
        
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        
        let result =  phoneTest.evaluate(with: value)
        print(" ijnnnn   \(result)")
        return result
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
