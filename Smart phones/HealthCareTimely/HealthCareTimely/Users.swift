//
//  Users.swift
//  HealthCareTimely
//
//  Created by Pooja Pingle on 4/25/18.
//  Copyright © 2018 Pooja Pingle. All rights reserved.
//

import Foundation


class Users: NSObject{
    var firstname : String
    var roleText : String
    var username : String
    
    
    
    
    init(firstname : String, roleText : String, username : String) {
        self.firstname   = firstname
        self.roleText = roleText
        self.username  = username
        
    }
    
}
