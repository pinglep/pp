//
//  ViewAppointmentViewController.swift
//  HealthCareTimely
//
//  Created by Pooja Pingle on 4/25/18.
//  Copyright © 2018 Pooja Pingle. All rights reserved.
//

import UIKit

class ViewAppointmentViewController: UIViewController {
    var ap = [Appointment]()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func fetchData(){
        do{
            
            ap = try context.fetch(Appointment.fetchRequest())
            for a in ap{
                print("appointment" , a.symptons!)
            }
            
            
        }catch{
            // handle error
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
