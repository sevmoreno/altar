//
//  Posts.swift
//  altar
//
//  Created by Juan Moreno on 9/18/19.
//  Copyright © 2019 Juan Moreno. All rights reserved.
//

import UIKit

class Posts {
    
    var church: String!
    var author: String
    var likes: Int!
    var photoImage: String!
    var userID: String!
    var postID: String!
    var userPhoto: String!
    var postType: String!
    var message: String!
    
    
    var whoLikes: [String] = [String] ()
    
    
    init(dictionary: [String: Any]) {
        //self.user = user
        self.author = dictionary["author"] as? String ?? ""
        self.church = dictionary["church"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.photoImage = dictionary["photoImage"] as? String ?? "No image"
        self.userID = dictionary["userID"] as? String ?? ""
        self.postID = dictionary["postID"] as? String ?? ""
        self.userPhoto = dictionary["userPhoto"] as? String ?? ""
        self.postType = dictionary["postType"] as? String ?? ""
        self.message = dictionary["message"] as? String ?? ""
      //  let secondsFrom1970 = dictionary["creationDate"] as? Double ?? 0
      //  self.creationDate = Date(timeIntervalSince1970: secondsFrom1970)
    }
    
}
