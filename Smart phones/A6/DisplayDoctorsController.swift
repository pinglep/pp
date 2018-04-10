//
//  DisplayRoomsController.swift
//  A6
//
//  Created by Pooja Pingle on 3/3/18.
//  Copyright © 2018 Pooja Pingle. All rights reserved.
//

import UIKit

class DisplayRoomsController: UIViewController {
    var doc = [Doctors]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var roomdetailsView: UITextView!
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchData()
        roomdetailsView.text = ""
        for r in doc{
        roomdetailsView.text=roomdetailsView.text + "\nRoom with name'\(r.name!)'"
             
        }
        
    }
    func fetchData(){
        do{
            doc = try context.fetch(Doctors.fetchRequest())
        }catch{
            // handle error
        }
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
