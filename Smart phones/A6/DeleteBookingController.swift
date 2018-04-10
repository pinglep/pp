//
//  DeleteBookingController.swift
//  A6
//
//  Created by Pooja Pingle on 3/3/18.
//  Copyright © 2018 Pooja Pingle. All rights reserved.
//

import UIKit
import CoreData

class DeleteBookingController: UIViewController, UITextFieldDelegate {
    var bookings = [Bookings]()
    @IBOutlet weak var bookingid: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    var foods = [String]()
    var aa: String?
    @IBOutlet weak var label: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        for b in bookings{
            foods.append(b.bookingName!)
        }
        dp()
        self.bookingid.delegate = self

        // Do any additional setup after loading the view.
    }
    func fetchData(){
        do{
            bookings = try context.fetch(Bookings.fetchRequest())
        }catch{
            // handle error
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        bookingid.resignFirstResponder()
        return (true)
    }

    @IBOutlet weak var deletebooking: UIButton!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backButtonAddCPage(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }

    @IBAction func deletebooking(_ sender: Any) {
        
        let roomNameDel = bookingid.text!
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Bookings")
        request.returnsObjectsAsFaults = false
        var stringName : String  = String()
        
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                stringName  = data.value(forKey: "bookingName") as! String
                if stringName == roomNameDel{
                    do {
                        try context.delete(data)
                        for (index, name) in foods.enumerated(){
                            if name == stringName{
                                foods.remove(at: index);
                            }
                            
                        }
                        appDelegate.saveContext()
                        do{
                            bookings = try context.fetch(Bookings.fetchRequest())
                        }catch{
                            // handle error
                        }
                                                let alertView = UIAlertView();
                                                alertView.addButton(withTitle: "OK");
                                                alertView.title = "Alert";
                                                alertView.message = "Booking deleted successfully";
                                                alertView.show();
                        dismiss(animated: true, completion: nil)
                    } catch {
                        print("Failed saving")
                    }
                    
                }
                
            }
            
        } catch {
            
            print("Failed")
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
        bookingid.inputView = dayPicker
    }

}
extension DeleteBookingController: UIPickerViewDataSource, UIPickerViewDelegate{
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
        bookingid.text = aa
        
    }
    
}
