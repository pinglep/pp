//
//  DocEditViewController.swift
//  HealthCareTimely
//
//  Created by Pooja Pingle on 4/27/18.
//  Copyright © 2018 Pooja Pingle. All rights reserved.
//

import UIKit

import Firebase

class DocEditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var ref:DatabaseReference!
    var refHandle: UInt!
    
    let imagePickerController = UIImagePickerController()
    @IBOutlet weak var docname: UILabel!
    @IBOutlet weak var docnamenew: UILabel!
    @IBOutlet weak var docnameneww: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var speciality: UITextField!
    @IBOutlet weak var contact: UITextField!
    @IBOutlet weak var image: UIImageView!
    var uid : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
         fetchData()
        imagePickerController.delegate = self;
        ref = Database.database().reference()
        refHandle = ref.observe(DataEventType.value, with: { (snapshot) in
            self.contact.text = ""
            let userID = Auth.auth().currentUser?.uid
            self.uid = userID!
            self.ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                let dataDict = snapshot.value as! [String: AnyObject]
                
                let value = snapshot.value as? NSDictionary
                
                
                self.docnamenew.text = value?["firstname"] as? String ?? ""
                self.docnameneww.text = value?["firstname"] as? String ?? ""
                self.email.text = value?["username"] as? String ?? ""
                
                for ud in uad{
                    if ud.id == userID{
                        self.contact.text = ud.contact
                       self.speciality.text = ud.speciality!
                        
                    }
                }
                
            })
        })
        print("hello")
        for u in uad {
            print(u.firstname)
        }
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func fetchData(){
        do{
            doc = try context.fetch(Doctor.fetchRequest())
            pat = try context.fetch(Patient.fetchRequest())
            ap = try context.fetch(Appointment.fetchRequest())
            uad = try context.fetch(UserDetails.fetchRequest())
        }catch{
            // handle error
        }
    }

    @IBAction func imgeuplod(_ sender: Any) {
        imagePickerController.sourceType = .photoLibrary
        
        self.present(imagePickerController, animated: true, completion: nil)
        
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        image.contentMode = .scaleAspectFit
        
        image.image = chosenImage
        
        dismiss(animated:true, completion: nil)
        
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func submitp(_ sender: Any) {
        
        if speciality!.text! == ""{
            let alertView = UIAlertView();
            alertView.addButton(withTitle: "OK");
            alertView.title = "Alert";
            alertView.message = "Please enter speciality name";
            alertView.show();
        }else if contact!.text! == "" {
            let alertView = UIAlertView();
            alertView.addButton(withTitle: "OK");
            alertView.title = "Alert";
            alertView.message = "Please enter contact number";
            alertView.show();
        }else{
            
            let new  = isValidPhone(value :contact!.text!)
            if new == false{
                let alertView = UIAlertView();
                alertView.addButton(withTitle: "OK");
                alertView.title = "Alert";
                alertView.message = "Entered phone number is not valid";
                alertView.show();
                return;
            }else{
        for d in doc{
            if uid == d.docId{
                let u = UserDetails(context: context)
                u.firstname = docnamenew.text
                u.email = email.text
                u.contact = contact.text
                u.username = email.text
                u.speciality = speciality.text
                u.id = uid
                appDelegate.saveContext()
                let alertView = UIAlertView();
                alertView.addButton(withTitle: "OK");
                alertView.title = "Alert";
                alertView.message = "Your profile has been updated successfully";
                alertView.show();
                return;
                break;
                print("success")
                
            }
                }
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
