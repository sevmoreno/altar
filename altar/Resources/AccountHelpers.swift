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
    

    func loadCurrentUserInfo (completionHandler: @escaping (_ success:Bool) -> Void)  {
                 
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
                            
                            completionHandler(true)
                            
                         } else {
                            
                            completionHandler(false)
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
  
                   
    func creatChurch (userID: String, name: String, address: String?, state: String, country: String, zipCode: String?,email: String?,facebook: String?,instragram: String?, webSite: String?, phoneNumber: String?, displayname: String, completionHandler: @escaping (_ success:Bool) -> Void) {
        
        let userPostRef = Database.database().reference().child("Churchs")
        
        let uuid = UUID().uuidString
        
        let diction = ["userID" : userID,
                   "name" : name,
                   "address" : address,
                   "country" : country,
                   "state": state,
                   "zipCode" : zipCode,
                   "email" : email,
                   "facebook" : facebook,
                   "instragram" : instragram,
                    "webSite" : webSite,
                   "phoneNumber" : phoneNumber,
                   "uidChurch" : uuid
        
        ]
        
        userPostRef.child(uuid).updateChildValues(diction as [String : Any]) { (err, ref) in
                                      if let err = err {
                                          //self.navigationItem.rightBarButtonItem?.isEnabled = true
                                          print("Failed to save post to DB", err)
                                        completionHandler(false)
                                          return
                                      }
                                      
                                      print("Successfully saved new Church to DB")
            
                                        advengers.shared.currentChurch = displayname
                                        advengers.shared.currentChurchInfo = Church(dictionary: diction)
                                     
            
                                    completionHandler(true)
                                      
                                  }
        
        
        
    }
    
    func loadCurrentChurch () {
        
        
    }
    
    
    func loadChurchs ( completionHandler: @escaping (_ success:Bool,_ churchsLista: [NSDictionary]) -> Void) {
        
        Database.database().reference().child("Churchs").queryOrderedByKey().observe(.value) { (datasnap) in
             
             let churchdata = datasnap.value as! [String:NSDictionary]
            
            
            var churchsLista = [NSDictionary] ()
            
            for (_,value) in churchdata {
                
                churchsLista.append(value)
                
                print(value as? [String:String] as Any)
                
                 completionHandler(true, churchsLista)
                
            }
            
             
//             for (key, value) in churchdata {
//
//                 if key == Auth.auth().currentUser?.uid {
//                    advengers.shared.currenUSer["userid"] = value["userid"] as? String
//                    advengers.shared.currenUSer["email"] = value["email"] as? String
//                    advengers.shared.currenUSer["name"] = value["name"] as? String
//                    advengers.shared.currenUSer["photoURL"] = value["photoURL"] as? String
//                    advengers.shared.currenUSer["church"] = value["church"] as? String
//
//                    advengers.shared.currenUSer["churchID"] = value["churchID"] as? String
//
//                       advengers.shared.currenUSer["title"] = value["title"] as? String
//
//                      advengers.shared.currenUSer["isPastor"] = value["isPastor"] as? Int
//
//                    advengers.shared.currenUSer["uid"] = value["uid"] as? String
//
//                     advengers.shared.currentChurch = value["church"] as! String
//
//                    completionHandler(true, churchsLista)
//
//                 } else {
//
//                    completionHandler(false, churchsLista)
//                }
//             }
//
//         }
         
        
        
    }
       
        
    
}
    
    
    
}
