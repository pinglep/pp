//
//  Data.swift
//  HealthCareTimely
//
//  Created by Pooja Pingle on 4/26/18.
//  Copyright © 2018 Pooja Pingle. All rights reserved.
//

import Foundation


class Data: NSObject {
    static var apArray = [Appointment]()
    static var docArray = [Doctor]()
    static var patArray = [Patient]()
    static var userArray = [User]()
    
    static var uda = [UserDetails]()
    static func addCustomer(app : Appointment){
        apArray.append(app)
    }
    
    static func addCustomer(ud : UserDetails){
        uda.append(ud)
    }
    
    static func addRoom(doc : Doctor){
        docArray.append(doc)
    }
    
    static func patArray(pat : Patient){
        patArray.append(pat)
    }
    
    static func addCustomer(u : User){
        userArray.append(u)
    }
}
