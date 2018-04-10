 //
//  DisplayBookingController.swift
//  A6
//
//  Created by Pooja Pingle on 3/3/18.
//  Copyright © 2018 Pooja Pingle. All rights reserved.
//

import UIKit
import CoreData

class DisplayBookingController: UIViewController {
    var bookings = [Bookings]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var bookingdetails: UITextView!
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bookingdetails.text = ""
        fetchData()
        for b in bookings{
            bookingdetails.text=bookingdetails.text + "\nBooking id '\(b.bookingName!)' for customer \((b.relationship?.name!)!)"
            
        }
        
    }
    func fetchData(){
        do{
            bookings = try context.fetch(Bookings.fetchRequest())
        }catch{
            // handle error
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backButtonAddCPage(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
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
