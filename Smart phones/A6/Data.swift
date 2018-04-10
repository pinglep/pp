//
//  Data.swift
//  A6
//
//  Created by Pooja Pingle on 3/3/18.
//  Copyright © 2018 Pooja Pingle. All rights reserved.
//

import UIKit

class Data: NSObject {
    static var custArray = [Patients]()
    static var roomArray = [Doctors]()
    
    
    
    static func addCustomer(cust : Patients){
        custArray.append(cust)
    }
    
    static func addRoom(room : Doctors){
        roomArray.append(room)
    }
}
