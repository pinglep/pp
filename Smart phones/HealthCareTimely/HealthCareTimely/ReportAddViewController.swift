//
//  ReportAddViewController.swift
//  HealthCareTimely
//
//  Created by Pooja Pingle on 4/27/18.
//  Copyright © 2018 Pooja Pingle. All rights reserved.
//

import UIKit
import Firebase
import CoreData
var r = [Reports]()
class ReportAddViewController: UIViewController , UITextFieldDelegate{
    var p = [Patient]()
    var d = [Doctor]()
    var a = [Appointment]()
    
    
    @IBOutlet weak var patientPicker: UIPickerView!
    @IBOutlet weak var patientName: UITextField!
    @IBOutlet weak var diesease: UITextField!
    @IBOutlet weak var severity: UITextField!
    @IBOutlet weak var reportsAvailable: UISegmentedControl!
    var foods = [String]()
    var foodsId = [String]()
    var ref:DatabaseReference!
    var refHandle: UInt!
    var aa: String?
    var uid : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        for k in p{
            foods.append(k.firstname!)
            foodsId.append(k.patId!)
        }
        
        dp()
        self.patientName.delegate = self
        ref = Database.database().reference()
        refHandle = ref.observe(DataEventType.value, with: { (snapshot) in
            
            
            let userID = Auth.auth().currentUser?.uid
            self.uid = userID!
            self.ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                let dataDict = snapshot.value as! [String: AnyObject]
                
                
                let value = snapshot.value as? NSDictionary
                
                
                
            })
        })
        // Do any additional setup after loading the view.
    }
    func fetchData(){
        do{
            d = try context.fetch(Doctor.fetchRequest())
            p = try context.fetch(Patient.fetchRequest())
            a = try context.fetch(Appointment.fetchRequest())
            r = try context.fetch(Reports.fetchRequest())
            print(r.count)
            print(p.count)
            print(a.count)
            

            
        }catch{
            // handle error
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        patientName.resignFirstResponder()
        return (true)
    }
    func dp(){
        let dayPicker = UIPickerView()
        dayPicker.delegate = self
        patientName.inputView = dayPicker
    }

    @IBOutlet weak var diagnosed: UISegmentedControl!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitButton(_ sender: Any) {
        
        if patientName!.text! == ""{
            let alertView = UIAlertView();
            alertView.addButton(withTitle: "OK");
            alertView.title = "Alert";
            alertView.message = "Please select patient name";
            alertView.show();
        }else if diesease!.text! == "" {
            let alertView = UIAlertView();
            alertView.addButton(withTitle: "OK");
            alertView.title = "Alert";
            alertView.message = "Please enter symptons";
            alertView.show();
        }else if severity!.text! == "" {
            let alertView = UIAlertView();
            alertView.addButton(withTitle: "OK");
            alertView.title = "Alert";
            alertView.message = "Please enter from time";
            alertView.show();
        }else{
            
            for k in d{
                if uid == k.docId{
                    var puid : String = ""
                    for p1 in p {
                        if p1.firstname == patientName.text {
                            puid = p1.patId!
                            let r = Reports(context: context)
                            r.pName = patientName.text
                            r.severity = severity.text
                            r.disgnosed = dia
                            r.repavalable = ra
                            r.relationship = p1
                            r.relationship1 = k
                            appDelegate.saveContext()
                            let alertView = UIAlertView();
                            alertView.addButton(withTitle: "OK");
                            alertView.title = "Alert";
                            alertView.message = "Reports has beeen generated for the selected patient.";
                            alertView.show();
                            return;
                            break;
                            print("success")
                            
                        }
                    }
                }
            }
            
        }
            
    }
    var dia : String = "Yes"
    @IBAction func disgnosed(_ sender: Any) {
        switch diagnosed.selectedSegmentIndex
        {
        case 0:
            dia = "Yes";
        case 1:
            dia = "No";
        default:
            break
        }
        print(dia)
    }
    var ra : String = "Yes"
    @IBAction func reportsAvailable(_ sender: Any) {
        switch reportsAvailable.selectedSegmentIndex
        {
        case 0:
            ra = "Yes";
        case 1:
            ra = "No";
        default:
            break
        }
        print(ra)
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
extension ReportAddViewController: UIPickerViewDataSource, UIPickerViewDelegate{
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
        patientName.text = aa
        
        
    }
    
}
