//
//  ReviewViewController.swift
//  HealthCareTimely
//
//  Created by Pooja Pingle on 4/28/18.
//  Copyright © 2018 Pooja Pingle. All rights reserved.
//

import UIKit
import Firebase
class ReviewViewController: UIViewController, UITextFieldDelegate {
    var foods = [String]()
    var foodsId = [String]()
    var ref:DatabaseReference!
    var refHandle: UInt!
    var aa: String?
    var uid : String = ""
    @IBOutlet weak var com: UITextField!
    @IBOutlet weak var doctorname: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchData()
        for d in doc{
            foods.append(d.firstname!)
            foodsId.append(d.docId!)
        }
        dp()
        self.doctorname.delegate = self
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
    @IBOutlet weak var docpicker: UIPickerView!
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        doctorname.resignFirstResponder()
        return (true)
    }
    func dp(){
        let dayPicker = UIPickerView()
        docpicker.delegate = self
        doctorname.inputView = dayPicker
    }
    @IBOutlet weak var comments: UITextField!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitButton(_ sender: Any) {
        
        if doctorname!.text! == ""{
            let alertView = UIAlertView();
            alertView.addButton(withTitle: "OK");
            alertView.title = "Alert";
            alertView.message = "Please select doctor name";
            alertView.show();
        }else if comments!.text! == "" {
            let alertView = UIAlertView();
            alertView.addButton(withTitle: "OK");
            alertView.title = "Alert";
            alertView.message = "Please enter comments";
            alertView.show();
        }else{
            let alertView = UIAlertView();
            alertView.addButton(withTitle: "OK");
            alertView.title = "Alert";
            alertView.message = "Reviews saved successfully!!";
            alertView.show();
        }
    }
    
    
    var doc = [Doctor]()
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ReviewViewController: UIPickerViewDataSource, UIPickerViewDelegate{
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
        doctorname.text = aa
        
        
    }
    
}
