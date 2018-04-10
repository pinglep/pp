//
//  CreatingBookingController.swift
//  A6
//
//  Created by Pooja Pingle on 3/3/18.
//  Copyright © 2018 Pooja Pingle. All rights reserved.
//

import UIKit
import CoreData

class CreatingBookingController: UIViewController, UITextFieldDelegate {
    var pat = [Patients]()
    var doc = [Doctors]()
    var bookings = [Bookings]()
    @IBOutlet weak var custname: UITextField!
    @IBOutlet weak var roomname: UITextField!
    @IBOutlet weak var bookingid: UITextField!
    @IBOutlet weak var fromdate: UIDatePicker!
    @IBOutlet weak var todate: UIDatePicker!
    @IBOutlet weak var creatBooking: UIButton!
    @IBOutlet weak var SELECTION: UISegmentedControl!
    
    var foods = [String]()
    var aa: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        self.custname.delegate = self
        self.roomname.delegate = self
        self.bookingid.delegate = self
        for e in pat{
            foods.append(e.name!)
        }
        dp()
        
        self.fromdate.minimumDate = Date();
        
        self.todate.minimumDate = Date().addingTimeInterval(86400);
        // Do any additional setup after loading the view.
    }
    func fetchData(){
        do{
            pat = try context.fetch(Patients.fetchRequest())
            doc = try context.fetch(Doctors.fetchRequest())
            bookings = try context.fetch(Bookings.fetchRequest())
            
            for e in pat{
                print("name : \(e.name!)")
            }
            
        }catch{
            // handle error
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        custname.resignFirstResponder()
        roomname.resignFirstResponder()
        bookingid.resignFirstResponder()
        return (true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backButtonAddCPage(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    var custwithbooking : String = "false"
    @IBAction func createBooking(_ sender: Any) {
        
        if custname!.text! == ""{
            let alertView = UIAlertView();
            alertView.addButton(withTitle: "OK");
            alertView.title = "Alert";
            alertView.message = "Please enter customer name";
            alertView.show();
        }else if roomname!.text! == "" {
            let alertView = UIAlertView();
            alertView.addButton(withTitle: "OK");
            alertView.title = "Alert";
            alertView.message = "Please enter room name";
            alertView.show();
        }else if bookingid!.text! == "" {
            let alertView = UIAlertView();
            alertView.addButton(withTitle: "OK");
            alertView.title = "Alert";
            alertView.message = "Please enter booking id";
            alertView.show();
        }else{
            
            var notFound : String = "false"
            for b1 in bookings{
                
                print("in condition : \(b1.relationship!.name!)")
                if custname!.text! == b1.relationship!.name! {
                    print("ss")
                    custwithbooking = "true"
                }
            }
            
            print("first : \(custwithbooking)")
            if custwithbooking == "true"{
                let alertView = UIAlertView();
                alertView.addButton(withTitle: "OK");
                alertView.title = "Alert";
                alertView.message = "Booking is already available with given cust name";
                alertView.show();
                return;
            }else{
                if fromdate!.date.compare(todate!.date) == .orderedDescending {
                    let alertView = UIAlertView();
                    alertView.addButton(withTitle: "OK");
                    alertView.title = "Alert";
                    alertView.message = "😐 To date must be after From date";
                    alertView.show();
                    
                }else{
                    
                    for c1 in pat{
                        if custname!.text! == c1.name {
                            notFound = "true"
                            break;
                        }else{
                            notFound = "false"
                            
                        }
                        
                    }
                    if notFound == "false"{
                        let alertView = UIAlertView();
                        alertView.addButton(withTitle: "OK");
                        alertView.title = "Alert";
                        alertView.message = "Entered customer is not available";
                        alertView.show();
                    }else{
                        for cust in pat{
                            if custname!.text! == cust.name{
                                for room in doc{
                                    print("2")
                                    for bookingosfar in bookings {
                                        print("\(bookingosfar.relationship1!.name!)")
                                        if  roomname!.text! == bookingosfar.relationship1?.name!{
                                            print("3")
                                            if fromdate!.date.compare(bookingosfar.fromDate!) == .orderedSame {
                                                print("4")
                                                let alertView = UIAlertView();
                                                alertView.addButton(withTitle: "OK");
                                                alertView.title = "Alert";
                                                alertView.message = "😑 For the selected room name you can not make booking as room is already booked for that date range.";
                                                alertView.show();
                                                return;
                                                break;
                                            }else{
                                                print("5")
                                                let bookingF = Bookings(context: context)
                                                bookingF.bookingName = bookingid!.text!
                                                bookingF.fromDate = fromdate!.date
                                                bookingF.relationship = cust
                                                appDelegate.saveContext()
                                                
                                                let alertView = UIAlertView();
                                                alertView.addButton(withTitle: "OK");
                                                alertView.title = "Alert";
                                                alertView.message = "Booking successfully created";
                                                alertView.show();
                                                return;
                                                break;
                                                
                                                
                                            }
                                        }else{
                                            print("6")
                                            print("\(custwithbooking)")
                                            if custwithbooking == "true"{
                                                let alertView = UIAlertView();
                                                alertView.addButton(withTitle: "OK");
                                                alertView.title = "Alert";
                                                alertView.message = "Booking is already available with given cust name";
                                                alertView.show();
                                                return;
                                            }else{
                                                let bookingF = Bookings(context: context)
                                                bookingF.bookingName = bookingid!.text!
                                                bookingF.fromDate = fromdate!.date
                                                bookingF.relationship = cust
                                                appDelegate.saveContext()
                                                //
                                                
                                                custwithbooking = "true"
                                                
                                                let alertView = UIAlertView();
                                                alertView.addButton(withTitle: "OK");
                                                alertView.title = "Alert";
                                                alertView.message = "Booking successfully created";
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
    var roomtype : (String) = "S"
    @IBAction func SELECTION(_ sender: Any) {
        
        switch SELECTION.selectedSegmentIndex
        {
        case 0:
            roomtype = "S";
        case 1:
            roomtype = "D";
        default:
            break
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
    func dp(){
        let dayPicker = UIPickerView()
        dayPicker.delegate = self
        custname.inputView = dayPicker
    }
}
extension CreatingBookingController: UIPickerViewDataSource, UIPickerViewDelegate{
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
        custname.text = aa
        
    }
    
}
