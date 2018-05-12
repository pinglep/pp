//
//  NewViewController.swift
//  HealthCareTimely
//
//  Created by Pooja Pingle on 4/14/18.
//  Copyright © 2018 Pooja Pingle. All rights reserved.
//

import UIKit
import Firebase
import MessageUI
import FirebaseAuth

class NewViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    var pat = [Patient]()
    var doc = [Doctor]()
    var ap = [Appointment]()
    //var ucoredata = [Use]()
   
    
    @IBAction func viewRating(_ sender: Any) {
        
    }
    @IBAction func logoutButton(_ sender: Any) {
        
        if Auth.auth().currentUser != nil{
            do{
                try Auth.auth().signOut()
                dismiss(animated: true, completion: nil)
            }catch let error as NSError{
                print(error.localizedDescription)
                
            }
        }
    }
    
    @IBAction func newLogOutButton(_ sender: Any) {
        
        if Auth.auth().currentUser != nil{
            do{
                try Auth.auth().signOut()
                dismiss(animated: true, completion: nil)
            }catch let error as NSError{
                print(error.localizedDescription)
                
            }
    }
    }
    @IBOutlet weak var newLogout: UIButton!
    var ref:DatabaseReference!
    var refHandle: UInt!
    @IBOutlet weak var nameField: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var mainnameField: UILabel!
    @IBOutlet weak var roleTextField: UILabel!
    @IBOutlet weak var emailTextField: UILabel!
    @IBOutlet weak var mainview: UIView!
    @IBOutlet weak var lc: NSLayoutConstraint!
    @IBOutlet weak var tc: NSLayoutConstraint!
    var menuShowing = false
    var loggedInDoc : String = ""
    var role : String = ""
    var uname : String = ""
    var fname : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainview.layer.shadowOpacity = 1
        mainview.layer.shadowRadius = 10
        
        ref = Database.database().reference()
       
        refHandle = ref.observe(DataEventType.value, with: { (snapshot) in
            
            
            let userID = Auth.auth().currentUser?.uid
            self.ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                
                let value = snapshot.value as? NSDictionary
                self.nameField.text = value?["firstname"] as? String ?? ""
                self.loggedInDoc = value?["firstname"] as? String ?? ""
                
                self.role = value?["roleText"] as? String ?? ""
                self.uname = value?["username"] as? String ?? ""
                self.fname = value?["firstname"] as? String ?? ""
                
                
                self.name.text = value?["firstname"] as? String ?? ""
                self.mainnameField.text = value?["username"] as? String ?? ""
                self.roleTextField.text = value?["roleText"] as? String ?? ""
                self.emailTextField.text = value?["username"] as? String ?? ""
                
                var u = Users(firstname: self.fname, roleText: self.role, username: self.uname)
                
                print("in fetch")
                print(self.loggedInDoc)
                do{
                    self.pat = try context.fetch(Patient.fetchRequest())
                    self.doc = try context.fetch(Doctor.fetchRequest())
                    self.ap = try context.fetch(Appointment.fetchRequest())
                    
                    for a in self.ap {
                        print((a.relationship1?.docId))
                        
                        if(userID == a.relationship1?.docId){
                            print(true)
                        }
                        
                        
                    }
                    
                }catch{
                    // handle error
                }
               
            })
            
            
        })
        
    }
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
    
   
    @IBAction func l(_ sender: Any) {
        print("hi")
    }
    
    @IBAction func M(_ sender: Any) {
        
        if MFMessageComposeViewController.canSendText(){
            let controller = MFMessageComposeViewController()
            controller.body = "Message Body..."
            controller.recipients = ["+917021253870"]
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }else{
            print("sory")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func showMenu(_ sender: Any) {
        if menuShowing{
            lc.constant = 0
            tc.constant = 0
        }else{
            lc.constant = 200
            tc.constant = 300
        }
        menuShowing = !menuShowing
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
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
