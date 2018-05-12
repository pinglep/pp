//
//  DocApTableViewController.swift
//  HealthCareTimely
//
//  Created by Pooja Pingle on 4/25/18.
//  Copyright © 2018 Pooja Pingle. All rights reserved.
//

import UIKit
import Firebase
var filteredData = [String]()
var filteredData1 = [String]()
var filteredData2 = [String]()
var filteredData3 = [String]()
var filteredData4 = [String]()

var myIndex : Int = 0
class DocApTableViewController: UITableViewController {
    
    var app = [Appointment]()
    var a = [String]()
    var a1 = [String]()
    var a2 = [String]()
    var a3 = [String]()
    var a4 = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func fetchData(){
        let userID = Auth.auth().currentUser?.uid
        do{
            app = try context.fetch(Appointment.fetchRequest())
            print("into doctor list")
            
           
            for anew in app{
                print("otherwise")
                print(anew.relationship?.firstname!)
                print("end")
                print(anew.relationship1?.docId)
                print(userID)
                
                if userID == anew.relationship1?.docId{
                    print("patient name : ", (anew.relationship?.firstname!)!)
                    a.append((anew.relationship?.firstname!)!)
                    let date = NSDate()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let dateString = dateFormatter.string(from:(anew.date)! as Date)
                    print(dateString)
                    a1.append(dateString)
                    filteredData.append((anew.relationship?.firstname!)!)
                   
                    filteredData1.append(dateString)
                    a2.append(anew.fromTime!)
                    a3.append(anew.symptons!)
                     a4.append((anew.relationship?.patId)!)
                    filteredData2.append(anew.fromTime!)
                    
                    filteredData3.append(anew.symptons!)
                    filteredData4.append((anew.relationship?.patId)!)
                }
                
            }
            
            
        }catch{
            // handle error
        }
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
        return a.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "docapp"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? docviewappTableViewCell else {
            fatalError("The dequeued cell is not an instance of RoomTableViewCell.")
        }
        
        do{
            app = try context.fetch(Appointment.fetchRequest())
            let ac = a[indexPath.row]
            let ac1 = a1[indexPath.row]
            let ac2 = a2[indexPath.row]
            let ac3 = a3[indexPath.row]
            let ac4 = a4[indexPath.row]
            cell.patName.text = ac
            filteredData[indexPath.row] = ac
            cell.cellDate.text = ac1
            filteredData1[indexPath.row] = ac1
            filteredData2[indexPath.row] = ac2
            filteredData3[indexPath.row] = ac3
            filteredData4[indexPath.row] = ac4
        }
        catch{
            print("error")
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
//        performSegue(withIdentifier: "patientCiickCell", sender: self )
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
