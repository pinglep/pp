//
//  DoctorTableViewController.swift
//  HealthCareTimely
//
//  Created by Pooja Pingle on 4/24/18.
//  Copyright © 2018 Pooja Pingle. All rights reserved.
//

import UIKit
import Firebase

var newd = [String]()
var newd1 = [String]()
var myIndex2 : Int = 0
class DoctorTableViewController: UITableViewController {
    var doc = [Doctor]()
    var ref:DatabaseReference!
    var refHandle: UInt!
    var roleText = ""
    
    var firstname = ""
    
    var username =  ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        ref = Database.database().reference()
        refHandle = ref.observe(DataEventType.value, with: { (snapshot) in
            let userID = Auth.auth().currentUser?.uid
            self.ref.child("users").observe(.childAdded, with: { (snapshot) in
                let dataDict = snapshot.value as! [String: AnyObject]
                
                
                
                let value = snapshot.value as? NSDictionary
                
                 self.roleText = value?["roleText"] as? String ?? ""
                
                 self.firstname = value?["firstname"] as? String ?? ""
                
                 self.username = value?["username"] as? String ?? ""
                
                
                
            })
        })
        
        
        
    }
    func fetchData(){
        do{
            doc = try context.fetch(Doctor.fetchRequest())
            print("into doctor list")
            for d in doc{
                newd.append(d.firstname!)
                newd1.append(d.roleText!)
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
        return doc.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "doctorList"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? doctorTableViewCell else {
            fatalError("The dequeued cell is not an instance of RoomTableViewCell.")
        }
        
        do{
            doc = try context.fetch(Doctor.fetchRequest())
            let dc = doc[indexPath.row]
            cell.firstname.text = dc.firstname
            cell.roleText.text = dc.roleText
            
        }
        catch{
            print("error")
        }
        
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex2 = indexPath.row
        performSegue(withIdentifier: "segueDocToApp", sender: self )
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
