//
//  User.swift
//  altar
//
//  Created by Juan Moreno on 9/13/19.
//  Copyright © 2019 Juan Moreno. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var userID: String = ""
    var photoUser: String = ""
    var fullName: String = ""
    var churchUser: String = ""
    var email: String = ""
    var uid: String = ""
    

    init(uid: String, dictionary: [String: Any]) {
           self.fullName = dictionary["username"] as? String ?? ""
           self.photoUser = dictionary["photoURL"]  as? String ?? ""
           self.userID = dictionary["userid"] as? String ?? ""
           self.churchUser = dictionary["church"]  as? String ?? ""
        
           self.uid = uid
       }
    
}
