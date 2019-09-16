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
    
    
    static let shared = advengers ()
    
    let usersStatusRef = Database.database().reference(withPath: "users")
    
    
    // -------------------- NEWS TOOOLS -------------------
    let lastNewsRef = Database.database().reference().child ("last_news")
    // var newsfeeds = [newFeed (newsDate: "", url: "", thumbURL: "", title: "", subtitle: "", bodyText: "")]
    
   
    var currentChurch = "Favor Day"
    
    let storageRef = Storage.storage().reference()
    
    let pathsRef = Database.database().reference().child ("Paths")
    
    let mediaRef = Database.database().reference().child ("Media")
    
   
    

    
    
    private init() {
        
    }
    
    // Singleton POWER
    
    
    
}

