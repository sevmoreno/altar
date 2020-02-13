//
//  File.swift
//  altar
//
//  Created by Juan Moreno on 2/12/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

struct wSong {
    
   
    var author: String! = ""
    var title: String! = ""
    var songID: String! = ""
    var photoURL: String! = ""
    var durationSeg: Int = 0
    var songURL: String! = ""

  
    

    init(dictionary: [String: Any]) {
               self.author = dictionary["author"] as? String ?? ""
               self.title = dictionary["title"] as? String ?? ""
               self.songID = dictionary["songID"] as? String

               self.durationSeg = dictionary["durationSeg"] as? Int ?? 0
        
                self.songURL = dictionary["songURL"] as? String
        

      

    }
    
}
