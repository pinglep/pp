//
//  AppointedPatienDeatilsViewController.swift
//  HealthCareTimely
//
//  Created by Pooja Pingle on 4/25/18.
//  Copyright © 2018 Pooja Pingle. All rights reserved.
//

import UIKit
import Firebase
import CoreData
import MessageUI
class AppointedPatienDeatilsViewController: UIViewController , MFMessageComposeViewControllerDelegate{
    var aa: String?
    var pat = [Patient]()
    var doc = [Doctor]()
    var ap = [Appointment]()
    var u = [UserDetails]()
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var symptoms: UILabel!
    @IBOutlet weak var toTime: UITextField!
    @IBOutlet weak var comments: UITextField!
    @IBOutlet weak var suggesteddoc: UITextField!
    @IBOutlet weak var changedtime: UITextField!
    @IBOutlet weak var datepicker: UIDatePicker!
    @IBOutlet weak var dd: UIButton!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var patientName: UILabel!
    var foods = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        patientName.text = filteredData[myIndex]
        date.text = filteredData1[myIndex]
        time.text = filteredData2[myIndex]
        symptoms.text = filteredData3[myIndex]
        
        print("filteredData3[myIndex]filteredData3[myIndex]filteredData3[myIndex]", filteredData4[myIndex])
        // Do any additional setup after loading the view.
        
        fetchData()
        
        
        for a in ap{
            
            print("(a.relationship1?.firstname)!", (a.relationship1?.firstname)!)
            foods.append((a.relationship1?.firstname)!)
        }
        
        self.datepicker.minimumDate = Date();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func fetchData(){
        do{
            doc = try context.fetch(Doctor.fetchRequest())
            pat = try context.fetch(Patient.fetchRequest())
             ap = try context.fetch(Appointment.fetchRequest())
            u = try context.fetch(UserDetails.fetchRequest())
            for d in doc{
                print("main booking number" , d.firstname!)
            }
            
            
        }catch{
            // handle error
        }
    }
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func MESSAGE(_ sender: Any) {
        
            if MFMessageComposeViewController.canSendText(){
                print("in")
                var contct : String = ""
                print(patientName.text, "patientName.text")
                print(u.count, "udount")
                for u in uad {
                    
                    print("in2")
                    if patientName.text! == u.firstname{
                        
                        print("inside")
                        contct = u.contact!
                        print(contct)
                    }
                }
                
                print("contct", contct)
                let controller = MFMessageComposeViewController()
                controller.body = "Your appointment has been changed on \(date.text!) it will start from \(time.text!):00 AM"
                controller.recipients = [contct]
                controller.messageComposeDelegate = self
                self.present(controller, animated: true, completion: nil)
            }else{
                print("sory")
            }
                
    }
    
    @IBAction func changeAppointment(_ sender: Any) {
        
        if changedtime!.text! == ""{
            let alertView = UIAlertView();
            alertView.addButton(withTitle: "OK");
            alertView.title = "Alert";
            alertView.message = "Please enter time";
            alertView.show();
        }else if comments!.text! == "" {
            let alertView = UIAlertView();
            alertView.addButton(withTitle: "OK");
            alertView.title = "Alert";
            alertView.message = "Please enter comments";
            alertView.show();
        }else{
            
            
            let inftime:Int? = Int(changedtime.text!) // firstText is UITextField
            let inttime:Int? = Int(toTime.text!)
            print(changedtime.text , "changedtime")
             print(toTime.text , "toTime")
            
            print(inftime , "inftime")
            print(inttime , "toTime")
            let userID = Auth.auth().currentUser?.uid
            for d in doc{
                if userID == d.docId{
                    for p in pat{
                        if p.patId == filteredData4[myIndex] {
                            
                            if inftime == inttime{
                                let alertView = UIAlertView();
                                alertView.addButton(withTitle: "OK");
                                alertView.title = "Alert";
                                alertView.message = "From and to time can not be the same";
                                alertView.show();
                                return;
                                break;
                            }else if inftime! > inttime!{
                                let alertView = UIAlertView();
                                alertView.addButton(withTitle: "OK");
                                alertView.title = "Alert";
                                alertView.message = "to time should be after from time";
                                alertView.show();
                                return;
                                break;
                            }else {
                                
                               
                                
                                
                            let a = Appointment(context: context)
                            a.date = datepicker.date
                            a.fromTime = changedtime.text
                            a.toTime = toTime.text
                            a.symptons = symptoms!.text!
                            a.relationship = p
                            a.relationship1 = d
                            
                            a.relationship?.patId = filteredData4[myIndex]
                            a.relationship1?.docId = userID
                            appDelegate.saveContext()
                                
                                let alertView = UIAlertView();
                                alertView.addButton(withTitle: "OK");
                                alertView.title = "Alert";
                                alertView.message = "Appointment is changed successfully!!!";
                                alertView.show();
                                return;
                                
                               
                            }
                        }
                    }
                }
            }
            
            
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let alertView = UIAlertView();
        alertView.addButton(withTitle: "OK");
        alertView.title = "Alert";
        alertView.message = "Message has been send to the patient!";
        alertView.show();
       
        
        suggesteddoc.resignFirstResponder()
        return (true)
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
