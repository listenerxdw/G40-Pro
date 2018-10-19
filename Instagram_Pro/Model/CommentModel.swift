//
//  CommentModel.swift
//  Instagram_Pro
//
//  Created by Srujan Valluri on 18/10/18.
//  Copyright © 2018 unimelb_daweixu. All rights reserved.
//

import Foundation

struct CommentModel {
    
    let user: User
    
    let text: String
    let uid: String
    
    init(user: User, dictionary: [String: Any]) {
        self.user = user
        self.text = dictionary["text"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
}
