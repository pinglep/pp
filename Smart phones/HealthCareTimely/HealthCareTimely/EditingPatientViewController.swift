//
//  EditingPatientViewController.swift
//  HealthCareTimely
//
//  Created by Pooja Pingle on 4/27/18.
//  Copyright © 2018 Pooja Pingle. All rights reserved.
//

import UIKit
import Firebase

var uad = [UserDetails]()
class EditingPatientViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    var ref:DatabaseReference!
    var refHandle: UInt!
    @IBOutlet weak var patinetName: UILabel!
    @IBOutlet weak var patientNameNew: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var contactNumber: UITextField!
    @IBOutlet weak var birthdate: UIDatePicker!
    @IBOutlet weak var imagePick: UIImageView!
    @IBOutlet weak var uploadImage: UIButton!
    var uid : String = ""
    let imagePickerController = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        
        imagePickerController.delegate = self;
        ref = Database.database().reference()
        refHandle = ref.observe(DataEventType.value, with: { (snapshot) in
            self.contactNumber.text = ""
            let userID = Auth.auth().currentUser?.uid
            self.uid = userID!
            self.ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                let dataDict = snapshot.value as! [String: AnyObject]
                
                let value = snapshot.value as? NSDictionary
                
                
                self.patinetName.text = value?["firstname"] as? String ?? ""
                self.patientNameNew.text = value?["firstname"] as? String ?? ""
                self.email.text = value?["username"] as? String ?? ""
                
                for ud in uad{
                    if ud.id == userID{
                        self.contactNumber.text = ud.contact
                        self.birthdate.date = ud.dob!
                        
                    }
                }
                
            })
        })

        // Do any additional setup after loading the view.
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func upload(_ sender: Any) {
        imagePickerController.sourceType = .photoLibrary
        
        self.present(imagePickerController, animated: true, completion: nil)
        
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imagePick.contentMode = .scaleAspectFit
        
        imagePick.image = chosenImage
        
        dismiss(animated:true, completion: nil)
        
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func submit(_ sender: Any) {
        if contactNumber!.text! == "" {
            let alertView = UIAlertView();
            alertView.addButton(withTitle: "OK");
            alertView.title = "Alert";
            alertView.message = "Please enter contact number";
            alertView.show();
        }else{
            let new  = isValidPhone(value :contactNumber!.text!)
            if new == false{
                let alertView = UIAlertView();
                alertView.addButton(withTitle: "OK");
                alertView.title = "Alert";
                alertView.message = "Entered phone number is not valid";
                alertView.show();
                return;
            }else{
        for p in pat{
            if uid == p.patId{
                let u = UserDetails(context: context)
                u.firstname = patinetName.text
                u.email = email.text
                u.contact = contactNumber.text
                u.username = email.text
                u.dob = birthdate.date
                u.id = uid
                u.speciality = ""
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
