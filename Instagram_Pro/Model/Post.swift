//
//  Post.swift
//  Instagram_Pro
//
//  Created by DAWEIXU on 2018/10/17.
//  Copyright © 2018 unimelb_daweixu. All rights reserved.
//

import Foundation

//struct Post {
//    let imageUrl: String
//    init(dictionary: [String: Any]) {
//        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
//    }
//}


struct Post {
    
    var id: String?
    
    let user: User
    let imageUrl: String
    let caption: String
    let creationDate: Date
    
    var hasLiked = false
    
    init(user: User, dictionary: [String: Any]) {
        self.user = user
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.caption = dictionary["caption"] as? String ?? ""
        
        let secondsFrom1970 = dictionary["creationDate"] as? Double ?? 0
        self.creationDate = Date(timeIntervalSince1970: secondsFrom1970)
    }
}
