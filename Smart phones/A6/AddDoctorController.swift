//
//  AddRoomController.swift
//  A6
//
//  Created by Pooja Pingle on 3/3/18.
//  Copyright © 2018 Pooja Pingle. All rights reserved.
//

import UIKit

class AddRoomController: UIViewController,
    UITextFieldDelegate {

    @IBOutlet weak var roomname: UITextField!
    @IBOutlet weak var roomprice: UITextField!
    @IBOutlet weak var addroomb: UIButton!
    @IBOutlet weak var roomSelection: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.roomname.delegate = self
        self.roomprice.delegate = self
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        roomname.resignFirstResponder()
        roomprice.resignFirstResponder()
        return (true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backButtonAddCPage(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    var roomtype : (String)="S"
    @IBAction func roomselection(_ sender: Any) {
        
        switch roomSelection.selectedSegmentIndex
        {
        case 0:
            roomtype = "S";
        case 1:
            roomtype = "D";
        default:
            break
        }
    }
    @IBAction func addroom(_ sender: Any) {
        if roomname!.text! == ""{
            let alertView = UIAlertView();
            alertView.addButton(withTitle: "OK");
            alertView.title = "Alert";
            alertView.message = "Please enter doctor name";
            alertView.show();
        }else if roomprice!.text! == "" {
            let alertView = UIAlertView();
            alertView.addButton(withTitle: "OK");
            alertView.title = "Alert";
            alertView.message = "Please enter identification";
            alertView.show();
        }else{
            let rooms = Doctors(context: context)
            rooms.name = roomname!.text!
            
            let alertView = UIAlertView();
            alertView.addButton(withTitle: "OK");
            alertView.title = "Alert";
            alertView.message = "Doctor successfully created";
            alertView.show();
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

}
