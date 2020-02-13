//
//  Church.swift
//  altar
//
//  Created by Juan Moreno on 2/12/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import Foundation


import UIKit

class Church: NSObject {
    
    var userID: String = ""

    var name: String = ""
    var address: String = ""
    var state: String = ""
    var country: String = ""
    var zipCode: String = ""
    var email: String = ""
    var facebook: String = ""
    var instragram: String = ""
    var webSite: String = ""
    var phoneNumber: String = ""
    var uidChurch: String = ""
    
    var channelActive: String = "8107D0A2-4233-41D4-A9FC-D72C84E34C78"

    init(dictionary: [String: Any]) {
           self.name = dictionary["name"] as? String ?? ""
           self.address = dictionary["address"]  as? String ?? ""
           self.userID = dictionary["userid"] as? String ?? ""
           self.country = dictionary["country"]  as? String ?? ""
            self.state = dictionary["state"]  as? String ?? ""
           
           self.zipCode = dictionary["zipCode"] as? String ?? ""
           self.email = dictionary["email"]  as? String ?? ""
           self.facebook = dictionary["facebook"] as? String ?? ""
           self.instragram = dictionary["instragram"]  as? String ?? ""
        
           self.webSite = dictionary["webSite"]  as? String ?? ""
           self.phoneNumber = dictionary["phoneNumber"] as? String ?? ""
           self.uidChurch = dictionary["uidChurch"]  as? String ?? ""
        
           self.userID = dictionary["userID"]  as? String ?? ""
        
        
           
       }
    
}
