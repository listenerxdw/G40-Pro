//
//  User.swift
//  Instagram_Pro
//
//  Created by Yuri on 2018/10/18.
//  Copyright © 2018年 unimelb_daweixu. All rights reserved.
//


import Foundation

struct User {
    
    let uid: String
    let username: String
    let profileImageUrl: String
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"]  as? String ?? ""
    }
}
