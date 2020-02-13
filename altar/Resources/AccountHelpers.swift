//
//  AccountHelpers.swift
//  altar
//
//  Created by Juan Moreno on 2/13/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class AccountHelpers  {
    

    func loadCurrentUserInfo ()  {
                 
                 advengers.shared.usersStatusRef.queryOrderedByKey().observe(.value) { (datasnap) in
                     
                     let userinfo = datasnap.value as! [String:NSDictionary]
                     
                     for (key, value) in userinfo {
                         
                         if key == Auth.auth().currentUser?.uid {
                            advengers.shared.currenUSer["userid"] = value["userid"] as? String
                            advengers.shared.currenUSer["email"] = value["email"] as? String
                            advengers.shared.currenUSer["name"] = value["name"] as? String
                            advengers.shared.currenUSer["photoURL"] = value["photoURL"] as? String
                            advengers.shared.currenUSer["church"] = value["church"] as? String
                            
                            advengers.shared.currenUSer["churchID"] = value["churchID"] as? String
                           
                               advengers.shared.currenUSer["title"] = value["title"] as? String
                            
                              advengers.shared.currenUSer["isPastor"] = value["isPastor"] as? Int
                            
                            advengers.shared.currenUSer["uid"] = value["uid"] as? String
                        
                             advengers.shared.currentChurch = value["church"] as! String
                         }
                     }
                     
                 }
                 
                 
                 
             }
    
    
    func fetchUserInfo() {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            
            // observeSingleEvent una marenra fancy de decir leer datos
            
            advengers.shared.usersStatusRef.child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                print(snapshot.value ?? "")
//
//                guard let dictionary = snapshot.value as? [String: Any] else { return }
//
//                let username = dictionary["username"] as? String
//                self.navigationItem.title = username
                
            }) { (err) in
                print("Failed to fetch user:", err)
            }
        }
  
    
}
