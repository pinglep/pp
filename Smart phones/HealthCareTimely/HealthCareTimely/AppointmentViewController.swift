//
//  AppointmentViewController.swift
//  HealthCareTimely
//
//  Created by Pooja Pingle on 4/24/18.
//  Copyright © 2018 Pooja Pingle. All rights reserved.
//

import UIKit
import Firebase


var pat = [Patient]()
var doc = [Doctor]()
var ap = [Appointment]()
class AppointmentViewController: UIViewController, UITextFieldDelegate {
    var docID : String = ""
    
    @IBOutlet weak var totime: UITextField!
    @IBOutlet weak var fromrimeonme: UITextField!
    @IBOutlet weak var pickevi: UIPickerView!
    @IBOutlet weak var fromtime: UITextField!
    var foods = [String]()
    var foodsId = [String]()
    var ref:DatabaseReference!
    var refHandle: UInt!
     var aa: String?
    @IBOutlet weak var buttonsubmit: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var doctornametext: UITextField!
    @IBOutlet weak var symptons: UITextField!
    @IBOutlet weak var userText: UILabel!
    var uid : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        for d in doc{
            foods.append(d.firstname!)
            foodsId.append(d.docId!)
        }
        dp()
        self.doctornametext.delegate = self
        ref = Database.database().reference()
        refHandle = ref.observe(DataEventType.value, with: { (snapshot) in
            
            
            let userID = Auth.auth().currentUser?.uid
            self.uid = userID!
            self.ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                let dataDict = snapshot.value as! [String: AnyObject]
                
                
                let value = snapshot.value as? NSDictionary
                
                
                self.userText.text = value?["firstname"] as? String ?? ""
                
                
                
            })
        })
        self.datePicker.minimumDate = Date();
        
        // Do any additional setup after loading the view.
    }
    func fetchData(){
        do{
            doc = try context.fetch(Doctor.fetchRequest())
            pat = try context.fetch(Patient.fetchRequest())
            ap = try context.fetch(Appointment.fetchRequest())
            for d in doc{
                print("main booking number" , d.firstname!)
            }
            
            
        }catch{
            // handle error
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        doctornametext.resignFirstResponder()
        return (true)
    }
    func dp(){
        let dayPicker = UIPickerView()
        dayPicker.delegate = self
        doctornametext.inputView = dayPicker
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func submitAppointment(_ sender: Any) {
        
        if doctornametext!.text! == ""{
            let alertView = UIAlertView();
            alertView.addButton(withTitle: "OK");
            alertView.title = "Alert";
            alertView.message = "Please select doctor name";
            alertView.show();
        }else if symptons!.text! == "" {
            let alertView = UIAlertView();
            alertView.addButton(withTitle: "OK");
            alertView.title = "Alert";
            alertView.message = "Please enter symptons";
            alertView.show();
        }else if fromtime!.text! == "" {
            let alertView = UIAlertView();
            alertView.addButton(withTitle: "OK");
            alertView.title = "Alert";
            alertView.message = "Please enter from time";
            alertView.show();
        }else if totime!.text! == "" {
            let alertView = UIAlertView();
            alertView.addButton(withTitle: "OK");
            alertView.title = "Alert";
            alertView.message = "Please enter gto time";
            alertView.show();
        }else{
            let ftime:Int? = Int(fromtime.text!) // firstText is UITextField
            let ttime:Int? = Int(totime.text!)
            var duid : String = ""
            var sd :(Date)
            var nd :(Date)
            for dmain in doc{
                if doctornametext!.text! == dmain.firstname {
                    duid = dmain.docId!
                }
            }
            
            
            if ap.count == 0 {
                for p in pat{
                    if p.firstname == userText.text!{
                        for d in doc{
                            if d.firstname == doctornametext!.text!{
                                let new  = isValidPhone(value :fromtime!.text!)
                                let new1 = isValidPhone(value :totime!.text!)
                               
                                if new == false, new1 == false{
                                    let alertView = UIAlertView();
                                    alertView.addButton(withTitle: "OK");
                                    alertView.title = "Alert";
                                    alertView.message = "From and ";
                                    alertView.show();
                                    return;
                                }else{
                                
                                if ftime == ttime{
                                    let alertView = UIAlertView();
                                    alertView.addButton(withTitle: "OK");
                                    alertView.title = "Alert";
                                    alertView.message = "From and to time can not be the same";
                                    alertView.show();
                                    return;
                                    break;
                                }else if ftime! > ttime!{
                                    let alertView = UIAlertView();
                                    alertView.addButton(withTitle: "OK");
                                    alertView.title = "Alert";
                                    alertView.message = "to time should be after from time";
                                    alertView.show();
                                    return;
                                    break;
                                }else {
                                let a = Appointment(context: context)
                                a.date = datePicker.date
                                a.fromTime = fromrimeonme!.text!
                                a.toTime = totime!.text!
                                a.symptons = symptons!.text!
                                a.relationship = p
                                a.relationship1 = d
                                a.userID = uid

                                a.relationship?.patId = uid
                                a.relationship1?.docId = duid
                                appDelegate.saveContext()


                                let alertView = UIAlertView();
                                alertView.addButton(withTitle: "OK");
                                alertView.title = "Alert";
                                alertView.message = "Appointment is confirmed successfully!!!";
                                alertView.show();
                                return;
                                break;
                                }
                            }
                        }
                        }
                    }
                }
            }else{
                
            for a in ap{
                   docID = ""
                   if a.relationship1?.firstname == doctornametext.text{
                                       docID = (a.relationship1?.docId)!;
                        }
            }
            
            for a in ap {
                    if a.relationship1?.docId == docID {
                        let inftime:Int? = Int(a.fromTime!) // firstText is UITextField
                        let inttime:Int? = Int(a.toTime!)
                        let previousFtime:Int? = inftime
                        var nd :(Date)
                        sd = a.date!
                        
                        print(datePicker.date, "datePicker.date")
                        print(sd, "sd")
                        
                        
                        
                        let sd :(Date)
                        let ed :(Date)
                        
                        ed = datePicker.date
                        
                        let hkCalendar = Calendar.current
                        let dateCompoent1 = hkCalendar.dateComponents([.year, .month, .day, .hour, .minute, .timeZone, .calendar,.weekday], from: a.date!)
                        
                        let dateComponent2 = hkCalendar.dateComponents([.year, .month, .day, .hour, .minute, .timeZone, .calendar,.weekday], from: ed)
                        
                    
                            
                        
                            
                        if dateCompoent1.year == dateComponent2.year && dateCompoent1.day == dateComponent2.day && dateCompoent1.month == dateComponent2.month {
                                print("2")
                            print("previousFtime", previousFtime)
                            print("ftime", ftime)
                            
                            if previousFtime == ftime {
                                print("time is same")
                                let alertView = UIAlertView();
                                alertView.addButton(withTitle: "OK");
                                alertView.title = "Alert";
                                alertView.message = "For the selected date and time doctor is busy please select other time";
                                alertView.show();
                                return;
                                break;
                            }else{
                                let new  = isValidPhone(value :fromtime!.text!)
                                let new1 = isValidPhone(value :totime!.text!)
                               
                                if new == false , new1 == false{
                                    let alertView = UIAlertView();
                                    alertView.addButton(withTitle: "OK");
                                    alertView.title = "Alert";
                                    alertView.message = "Entered phone number is not valid";
                                    alertView.show();
                                    return;
                                }else{
                                if ftime == ttime{
                                    let alertView = UIAlertView();
                                    alertView.addButton(withTitle: "OK");
                                    alertView.title = "Alert";
                                    alertView.message = "From and to time can not be the same";
                                    alertView.show();
                                    return;
                                    break;
                                }else if ftime! > ttime!{
                                    let alertView = UIAlertView();
                                    alertView.addButton(withTitle: "OK");
                                    alertView.title = "Alert";
                                    alertView.message = "to time should be after from time";
                                    alertView.show();
                                    return;
                                    break;
                                }else {
                                    for p in pat{
                                        if p.firstname == userText.text!{
                                            for d in doc{
                                                if d.firstname == doctornametext!.text!{
                                                    let a = Appointment(context: context)
                                                    a.date = datePicker.date
                                                    a.fromTime = fromrimeonme!.text!
                                                    a.toTime = totime!.text!
                                                    a.symptons = symptons!.text!
                                                    a.relationship = p
                                                    a.relationship1 = d
                                                    a.userID = uid
                                                    
                                                    a.relationship?.patId = uid
                                                    a.relationship1?.docId = duid
                                                    appDelegate.saveContext()
                                                    
                                                    
                                                    let alertView = UIAlertView();
                                                    alertView.addButton(withTitle: "OK");
                                                    alertView.title = "Alert";
                                                    alertView.message = "Appointment is confirmed successfully!!!";
                                                    alertView.show();
                                                    return;
                                                    break;
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            
                        }
                            
                            
                            
                            
                                
                            }else{
                                print("no date match")
                            let new  = isValidPhone(value :fromtime!.text!)
                            let new1 = isValidPhone(value :totime!.text!)
                            if new1 == false{
                                let alertView = UIAlertView();
                                alertView.addButton(withTitle: "OK");
                                alertView.title = "Alert";
                                alertView.message = "Entered phone number is not valid";
                                alertView.show();
                                return;
                            }
                            if new == false{
                                let alertView = UIAlertView();
                                alertView.addButton(withTitle: "OK");
                                alertView.title = "Alert";
                                alertView.message = "Entered phone number is not valid";
                                alertView.show();
                                return;
                            }else{
                                if ftime == ttime{
                                    let alertView = UIAlertView();
                                    alertView.addButton(withTitle: "OK");
                                    alertView.title = "Alert";
                                    alertView.message = "From and to time can not be the same";
                                    alertView.show();
                                    return;
                                    break;
                                }else if ftime! > ttime!{
                                    let alertView = UIAlertView();
                                    alertView.addButton(withTitle: "OK");
                                    alertView.title = "Alert";
                                    alertView.message = "to time should be after from time";
                                    alertView.show();
                                    return;
                                    break;
                                }else {
                                    for p in pat{
                                        if p.firstname == userText.text!{
                                            for d in doc{
                                                if d.firstname == doctornametext!.text!{
                                                    let a = Appointment(context: context)
                                                    a.date = datePicker.date
                                                    a.fromTime = fromrimeonme!.text!
                                                    a.toTime = totime!.text!
                                                    a.symptons = symptons!.text!
                                                    a.relationship = p
                                                    a.relationship1 = d
                                                    a.userID = uid
                                                    
                                                    a.relationship?.patId = uid
                                                    a.relationship1?.docId = duid
                                                    appDelegate.saveContext()
                                                    
                                                    
                                                    let alertView = UIAlertView();
                                                    alertView.addButton(withTitle: "OK");
                                                    alertView.title = "Alert";
                                                    alertView.message = "Appointment is confirmed successfully!!!";
                                                    alertView.show();
                                                    return;
                                                    break;
                                                }
                                            }
                                        }
                                    }
                                }
                            
                            }
                }
                        
                        
                        
                    }else{
                        print(ftime, "ftime")
                        print(ttime, "ttime")
                        print("No doctor matched u cn procede")
                        let new  = isValidPhone(value :fromtime!.text!)
                        let new1  = isValidPhone(value :totime!.text!)
                        
                        if new1 == false{
                            let alertView = UIAlertView();
                            alertView.addButton(withTitle: "OK");
                            alertView.title = "Alert";
                            alertView.message = "Entered phone number is not valid";
                            alertView.show();
                            return;
                        }
                        if new == false{
                            let alertView = UIAlertView();
                            alertView.addButton(withTitle: "OK");
                            alertView.title = "Alert";
                            alertView.message = "Entered phone number is not valid";
                            alertView.show();
                            return;
                        }else{
                        if ftime == ttime{
                            let alertView = UIAlertView();
                            alertView.addButton(withTitle: "OK");
                            alertView.title = "Alert";
                            alertView.message = "From and to time can not be the same";
                            alertView.show();
                            return;
                            break;
                        }else if ftime! > ttime!{
                            let alertView = UIAlertView();
                            alertView.addButton(withTitle: "OK");
                            alertView.title = "Alert";
                            alertView.message = "to time should be after from time";
                            alertView.show();
                            return;
                            break;
                        }else {
                            for p in pat{
                                if p.firstname == userText.text!{
                                    for d in doc{
                                        if d.firstname == doctornametext!.text!{
                                            let a = Appointment(context: context)
                                            a.date = datePicker.date
                                            a.fromTime = fromrimeonme!.text!
                                            a.toTime = totime!.text!
                                            a.symptons = symptons!.text!
                                            a.relationship = p
                                            a.relationship1 = d
                                            a.userID = uid
                                            
                                            a.relationship?.patId = uid
                                            a.relationship1?.docId = duid
                                            appDelegate.saveContext()
                                            
                                            
                                            let alertView = UIAlertView();
                                            alertView.addButton(withTitle: "OK");
                                            alertView.title = "Alert";
                                            alertView.message = "Appointment is confirmed successfully!!!";
                                            alertView.show();
                                            return;
                                            break;
                                        }
                                    }
                                }
                            }
                        }
                        
                }
                
                }
                }
                
            }
            
            
            
            
           
            
            

            
            
            
        }
        
        
        
        
        
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func isValidPhone(value: String) -> Bool {
        
        let PHONE_REGEX = "^[0-13]"
        
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        
        let result =  phoneTest.evaluate(with: value)
        print(" ijnnnn   \(result)")
        return result
    }

}
extension AppointmentViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return foods.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return foods[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        aa = foods[row]
        doctornametext.text = aa
        
        
    }
    
}

