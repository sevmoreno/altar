//
//  Advengers.swift
//  altar
//
//  Created by Juan Moreno on 9/13/19.
//  Copyright © 2019 Juan Moreno. All rights reserved.
//

import UIKit
import CoreData
import MapKit
import Firebase


class advengers {
    
    // --- The Singleton tharaaaaaaaaa
    
    var isPastor = true
    
    static let shared = advengers ()
    
    let usersStatusRef = Database.database().reference(withPath: "users")
    
    
    // -------------------- NEWS TOOOLS -------------------
    let lastNewsRef = Database.database().reference().child ("last_news")
    // var newsfeeds = [newFeed (newsDate: "", url: "", thumbURL: "", title: "", subtitle: "", bodyText: "")]
    
   let  postPrayFeed = Database.database().reference().child ("post_pray_feed")
    let PostPrayStorage = Storage.storage().reference().child("post_pray_feed")
    
    var currentChurch = "Favorday Church"
    
    let storageRef = Storage.storage().reference()
    
    let pathsRef = Database.database().reference().child ("Paths")
    
    let mediaRef = Database.database().reference().child ("Media")
    
    var currenUSer = ["church": "",
                      "email": "",
                      "name":"",
                      "photoURL":"",
                      "userid":""] as! [String:String]
    
    enum postType: String {
        case textOnly = "textOnly"
        case imageOnly = "imageOnly"
        case audio = "audio"
        case audioText = "audioText"
        case textImage = "textImage"
        case textBkground = "textBkground"
    }
    
    
    var seleccionVideo = elementoVideo ()

    
    
    private init() {
        
    }
    
    // Singleton POWER
    
    
  
    
    
}

