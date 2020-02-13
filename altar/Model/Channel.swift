//
//  Channel.swift
//  altar
//
//  Created by Juan Moreno on 2/12/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//


import Foundation
import UIKit

class wChannel {
    
    var church: String! = ""
    var author: String! = ""
    var title: String! = ""
    var lista: [String] = [""]
    var photoURL: String! = ""

    var creationDate: Date!
    
    
   func load(dictionary: [String: Any]) {
               self.author = dictionary["author"] as? String ?? ""
               self.church = dictionary["church"] as? String ?? ""
               self.title = dictionary["title"] as? String

               self.photoURL = dictionary["photoURL"] as? String
        
        self.lista  = dictionary["lista"] as! [String]
       
        let secondsFrom1970 = dictionary["creationDate"] as? Int64 ?? 0
        self.creationDate = Date(milliseconds: secondsFrom1970)
    }
    
    
}
