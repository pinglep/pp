//
//  ViewAppointmentsTableViewController.swift
//  HealthCareTimely
//
//  Created by Pooja Pingle on 4/25/18.
//  Copyright © 2018 Pooja Pingle. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class ViewAppointmentsTableViewController: UITableViewController {
    var n = [String]()
    var n2 = [String]()
    var app = [Appointment]()
     let userID = Auth.auth().currentUser?.uid

    override func viewDidLoad() {
        print("jvnvdvnd mai  akn")
        
        super.viewDidLoad()
        
        do{
           
            app = try context.fetch(Appointment.fetchRequest())
            print("userID" ,userID)
            for a in app{
                print(".relationship?.patId",a.relationship?.patId)
                if userID == a.relationship?.patId{
                    print("hiii")
                n.append((a.relationship1?.firstname!)!)
                n2.append(a.symptons!)
                }
            }
        }catch{
            // handle error
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return n.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "viewAppTable"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ViewAppointmentsCellTableViewCell else {
            fatalError("The dequeued cell is not an instance of RoomTableViewCell.")
        }
        
        do{
            app = try context.fetch(Appointment.fetchRequest())
            print("app",app.count)
            let a = n[indexPath.row]
            let a2 = n2[indexPath.row]
            cell.docname.text = a
            
            cell.symptons.text = a2
        }
        catch{
            print("error")
        }
        
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "segue", sender: self)
        
        self.performSegue(withIdentifier: "patientCellView", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "patientCellView" {
            
            let indexPath = tableView.indexPathForSelectedRow
            let appData = app[(indexPath?.row)!]
            let applicationViewViewController = segue.destination as! PatientCellClickViewController
            applicationViewViewController.appData = appData
        }
    }
    
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
