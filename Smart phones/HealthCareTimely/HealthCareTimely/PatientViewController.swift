//
//  PatientViewController.swift
//  HealthCareTimely
//
//  Created by Pooja Pingle on 4/24/18.
//  Copyright © 2018 Pooja Pingle. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
class PatientViewController: UIViewController {
    var pat = [Patient]()
    var doc = [Doctor]()
    var ap = [Appointment]()
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
    @IBOutlet weak var mainPatientview: UIView!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    var ref:DatabaseReference!
    var refHandle: UInt!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var firstName: UILabel!
    var menuShowing = false
    override func viewDidLoad() {
        super.viewDidLoad()
        mainPatientview.layer.shadowOpacity = 10
        mainPatientview.layer.shadowRadius = 10
        fetchData()
        ref = Database.database().reference()
        
        print("into patiented")
        refHandle = ref.observe(DataEventType.value, with: { (snapshot) in
           
           
            let userID = Auth.auth().currentUser?.uid
            self.ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                let dataDict = snapshot.value as! [String: AnyObject]
                
                
                
                let value = snapshot.value as? NSDictionary
                self.label.text = value?["username"] as? String ?? ""
                self.label2.text = value?["roleText"] as? String ?? ""
                self.firstName.text = value?["firstname"] as? String ?? ""
                
                
                    
            })
        })
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func fetchData(){
        do{
            pat = try context.fetch(Patient.fetchRequest())
            doc = try context.fetch(Doctor.fetchRequest())
            
            
        }catch{
            // handle error
        }
    }

    @IBAction func showMenuFunc(_ sender: Any) {
        if (menuShowing){
            
            leadingConstraint.constant = 0
            trailingConstraint.constant = 0
        }else {
            leadingConstraint.constant = 200
            trailingConstraint.constant = 300
            
            
        }
        UIView.animate(withDuration: 0.3,animations: {
            self.view.layoutIfNeeded()
        })
        menuShowing = !menuShowing
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
