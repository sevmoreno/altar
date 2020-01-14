//
//  chat.swift
//  altar
//
//  Created by Juan Moreno on 1/14/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import Foundation


struct Chat {
    var users: [String]
    var dictionary: [String: Any] {
        return ["users": users]
   }
}
extension Chat {
        init?(dictionary: [String:Any]) {
            guard let chatUsers = dictionary["users"] as? [String] else {return nil}
            self.init(users: chatUsers)
    }
}
