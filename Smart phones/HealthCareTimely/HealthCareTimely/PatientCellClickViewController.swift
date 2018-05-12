//
//  PatientCellClickViewController.swift
//  HealthCareTimely
//
//  Created by Pooja Pingle on 4/28/18.
//  Copyright © 2018 Pooja Pingle. All rights reserved.
//

import UIKit

class PatientCellClickViewController: UIViewController {
    @IBOutlet weak var patinetName: UILabel!
    @IBOutlet weak var symptoms: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var fromTime: UILabel!
    
    @IBOutlet weak var dateselected: UIDatePicker!
    @IBOutlet weak var Timeto: UILabel!
    var appData:Appointment!
    
    @IBOutlet weak var patientName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(appData.date)
        print(appData.fromTime)
        print(appData.toTime)
        print(appData.symptons)
       patinetName.text = appData.relationship?.firstname
        symptoms.text = appData.symptons
        fromTime.text = appData.fromTime
        Timeto.text = appData.toTime
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
