//
//  ViewController.swift
//  HealthCareTimely
//
//  Created by Pooja Pingle on 4/14/18.
//  Copyright © 2018 Pooja Pingle. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import CoreData
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate , UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func configureMailController() -> MFMailComposeViewController{
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["poojapingle16@gmail.com"])
        mailComposerVC.setSubject("Hello")
        mailComposerVC.setMessageBody("hi HOW ARe you doing", isHTML: false)
        
        return mailComposerVC
    }
    @IBOutlet weak var imageSelected: UIImageView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var messageButton: UIButton!
    
    @IBOutlet weak var reserPass: UIButton!
    @IBAction func callmain(_ sender: Any) {
        let url: NSURL = URL(string: "TEL://1234567890")! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    let imagePickerController = UIImagePickerController()
    @IBOutlet weak var callbutton: UIButton!
    @IBAction func CALL(_ sender: Any) {
        //var url:NSURL = NSURL(string: "tel://1234567890")!
        // UIApplication.shared.openURL(url)
        
        let mailComposeViewController = configureMailController()
        
        if MFMailComposeViewController.canSendMail(){
            self.present(mailComposeViewController, animated: true, completion: nil)
        }else{
            showMailError()
        }
    }
    
    func showMailError(){
        let sendMailErrorAlert = UIAlertController (title: "Could not load", message: "NO", preferredStyle: .alert)
        
        let dismiss = UIAlertAction(title: "OK", style: .default, handler: nil)
        sendMailErrorAlert.addAction(dismiss)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    var patient = [Patient]()
    var doctor = [Doctor]()
    var appointment = [Appointment]()

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var firstNameLabel: UILabel!
    var ref:DatabaseReference!
    var emailText: String = ""
    @IBOutlet weak var abcd: UISegmentedControl!
    @IBOutlet weak var signInSelector: UISegmentedControl!
    
    @IBOutlet weak var signInLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var roleSeclection: UISegmentedControl!
    
    @IBOutlet weak var signInButton: UIButton!
    
    var isSignIn:Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        self.roleSeclection.isHidden = true
        self.firstNameTextField.isHidden = true
        self.firstNameLabel.isHidden = true
        fetchData()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    var roleText : (String)="Doctor"
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        if let email = emailTextField.text, let pass = passwordTextField.text, let firstname = firstNameTextField.text{
          
            if isSignIn{
               
                Auth.auth().signIn(withEmail: email, password: pass, completion: { (user, error) in
                   
                    if let u = user {
                        var roleType : (String)=""
                        self.emailText = email
                        let userID = Auth.auth().currentUser?.uid
                        self.ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                            // Get user value
                            let value = snapshot.value as? NSDictionary
                            roleType = value?["roleText"] as? String ?? ""
                            if roleType == "Doctor" {
                                self.performSegue(withIdentifier: "goToHome", sender: self)
                            }
                            else if roleType == "Patient" {
                                self.performSegue(withIdentifier: "goTopatientview", sender: self)
                            }
                        }) { (error) in
                            print(error.localizedDescription)
                        }
                        
                      
                    }else{
                        
                        let alertView = UIAlertView();
                        alertView.addButton(withTitle: "OK");
                        alertView.title = "Alert";
                        alertView.message = "Error in login";
                        alertView.show();
                        
                    }
                })
            }else{
                print("3")
                Auth.auth().createUser(withEmail: email, password: pass, completion: { (user, error) in
                    
                    if let u = user {
                        self.ref.child("users").child(u.uid).setValue(["username": email,"firstname": firstname,"roleText": self.roleText])
                        
                        print("msin")
                        if self.roleText == "Doctor" {
                            self.performSegue(withIdentifier: "goToHome", sender: self)
                        }
                        else if self.roleText == "Patient" {
                            self.performSegue(withIdentifier: "goTopatientview", sender: self)
                        }
                        if(self.roleText == "Doctor"){
                            let datac1 = Doctor(context: context)
                            datac1.roleText = self.roleText
                            datac1.firstname = firstname
                            datac1.username = email
                            
                            print(" doc diidididiid" , u.uid)
                            datac1.docId = u.uid
                            
                        }else{
                            let datac1 = Patient(context: context)
                            datac1.roleText = self.roleText
                            datac1.firstname = firstname
                            datac1.username = email
                            datac1.patId = u.uid
                            
                           
                            
                        }
                        
                        
                        appDelegate.saveContext()
                    }else{
                        
                        let alertView = UIAlertView();
                        alertView.addButton(withTitle: "OK");
                        alertView.title = "Alert";
                        alertView.message = "Error in Registration";
                        alertView.show();
                        
                    }
                })
            }
            
           
        }
        
    }
    func fetchData(){
        do{
            patient = try context.fetch(Patient.fetchRequest())
            doctor = try context.fetch(Doctor.fetchRequest())
            
            
        }catch{
            // handle error
        }
    }
    @IBAction func roleSelectionFunc(_ sender: Any) {
        
        switch roleSeclection.selectedSegmentIndex
        {
        case 0:
            roleText = "Doctor";
        case 1:
            roleText = "Patient";
        default:
            break
        }
        print(roleText)
    }
    @IBAction func resetP(_ sender: Any) {
        resetEmailpassword(emailText: emailTextField.text!)
        let alertView = UIAlertView();
        alertView.addButton(withTitle: "OK");
        alertView.title = "Alert";
        alertView.message = "Email has been sent on your email id . Please check!!";
        alertView.show();
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func imageselected(_ sender: Any) {
        
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        image.allowsEditing = false
        
        self.present(image, animated: true){
            
        }
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imageSelected.image = image
        }else{
            
        }
        self.dismiss(animated: true){
            
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func resetEmailpassword(emailText: String){
    Auth.auth().sendPasswordReset(withEmail: emailText, completion: {
    (Error) in
    
        if Error == nil{
    print("An email with information on ")
        }
    })
    
    }
    @IBAction func abcd1(_ sender: UISegmentedControl) {
        
        isSignIn = !isSignIn
        if isSignIn {
            signInLabel.text = "Sign in"
            self.roleSeclection.isHidden = true
            self.firstNameTextField.isHidden = true
            self.firstNameLabel.isHidden = true
            signInButton.setTitle("Sign in", for: .normal)
        }else{
            
            signInLabel.text = "Register"
            self.roleSeclection.isHidden = false
            self.firstNameTextField.isHidden = false
            self.firstNameLabel.isHidden = false
            signInButton.setTitle("Register", for: .normal)
        }
    }
}

