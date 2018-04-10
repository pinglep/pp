//
//  ViewController.swift
//  A6
//
//  Created by Pooja Pingle on 3/3/18.
//  Copyright © 2018 Pooja Pingle. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var patient = [Patients]()
    var doctor = [Doctors]()
    var booking = [Bookings]()
    @IBOutlet weak var welc: UILabel!
    @IBOutlet weak var addCust: UIButton!
    @IBOutlet weak var addRoom: UIButton!
    @IBOutlet weak var createBooking: UIButton!
    @IBOutlet weak var displayRooms: UIButton!
    @IBOutlet weak var displayBooking: UIButton!
    @IBOutlet weak var searchbooking: UIButton!
    @IBOutlet weak var deleteBooking: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //insertData()
        fetchData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        welc.text = "Bienvenido To Booking"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addCustomer(_ sender: Any) {
        let ac = AddCustomerController(nibName: "AddCustomer", bundle: nil)
        self.present(ac, animated:true, completion: nil)
    }
    @IBAction func addRoom(_ sender: Any) {
        let ar = AddRoomController(nibName: "AddRoom", bundle: nil)
        self.present(ar, animated:true, completion: nil)
    }
    
    @IBAction func displayRoom(_ sender: Any) {
        let dr = DisplayRoomsController(nibName: "displayRoom", bundle: nil)
        self.present(dr, animated:true, completion: nil)
    }
    @IBAction func createBooking(_ sender: Any) {
        let cb = CreatingBookingController(nibName: "CreateBooking", bundle: nil)
        self.present(cb, animated:true, completion: nil)
    }
    
  
    @IBAction func displayBooking(_ sender: Any) {
        let db = DisplayBookingController(nibName: "DispayBooking", bundle: nil)
        self.present(db, animated:true, completion: nil)
    }
    @IBAction func deleteBookinhg(_ sender: Any) {
        let deb = DeleteBookingController(nibName: "DeleteBooking", bundle: nil)
        self.present(deb, animated:true, completion: nil)
    }
    func insertData(){
        let datac1 = Patients(context: context)
        datac1.name = "Sonal"
        datac1.idNumber = "dkufdf1"
        datac1.address = "Chicago"
        datac1.phoneNumber = 1234567890
        
        let datac2 = Patients(context: context)
        datac2.name = "Pooja"
        datac2.idNumber = "dkufdf1"
        datac2.address = "Boston"
        datac2.phoneNumber = 1234567890
        
        let datac3 = Patients(context: context)
        datac3.name = "Deepa"
        datac3.idNumber = "dkufdf1"
        datac3.address = "Philipines"
        datac3.phoneNumber = 1234567890
        
        let d1 = Doctors(context: context)
        d1.name = "AA"
       
        
        let d2 = Doctors(context: context)
        d2.name = "BB"
       
        let d3 = Doctors(context: context)
        d3.name = "CC"
       
        
        var f1dateFormatter = DateFormatter()
        f1dateFormatter.dateFormat = "dd/MM/yyyy"
        let f1d = f1dateFormatter.date(from: "24/02/2018")
        var t1dateFormatter = DateFormatter()
        t1dateFormatter.dateFormat = "dd/MM/yyyy"
        let t1d = t1dateFormatter.date(from: "28/02/2018")
        let booking1 = Bookings(context: context)
        booking1.bookingName = "B1"
        booking1.fromDate = f1d

        booking1.relationship = datac1
        booking1.relationship1 = d1
        
        
        var f3dateFormatter = DateFormatter()
        f3dateFormatter.dateFormat = "dd/MM/yyyy"
        let f3d = f3dateFormatter.date(from: "20/03/2018")
        var t3dateFormatter = DateFormatter()
        t3dateFormatter.dateFormat = "dd/MM/yyyy"
        let t3d = t3dateFormatter.date(from: "21/03/2018")
        let booking2 = Bookings(context: context)
        booking2.bookingName = "B2"
        booking2.fromDate = f3d
        booking2.relationship = datac2
        booking2.relationship1 = d2
        
        appDelegate.saveContext()
        
        
    }
    
    func fetchData(){
        do{
            patient = try context.fetch(Patients.fetchRequest())
            doctor = try context.fetch(Doctors.fetchRequest())
            booking = try context.fetch(Bookings.fetchRequest())
            
            for b in booking {
                print("room : \(b.bookingName)")
            }
        }catch{
            // handle error
        }
    }
}

