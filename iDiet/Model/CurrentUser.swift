//
//  CurrentUser.swift
//  iDiet
//
//  Created by Ahmad Karkouty on 11/25/18.
//  Copyright © 2018 Ahmad Karkouti. All rights reserved.
//

import UIKit
import Firebase

class CurrentUser {
    
    static var shared: CurrentUser = CurrentUser()
    
    var uid: String?
    var name: String?
    var email: String?
    var weight: String?
    var height: String?
    var target: String?
}

extension Database {
    static func fetchCurrentuser(uid: String, completion: @escaping (CurrentUser) ->()) {
        Database.database().reference().child("Users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else {return}
            
            let user = CurrentUser.shared
            user.uid = uid
            user.name = dictionary["Name"] as? String ?? ""
            user.email = dictionary["Email"] as? String ?? ""
            user.weight = dictionary["Weight"] as? String ?? ""
            user.height = dictionary["Height"] as? String ?? ""
            user.target = dictionary["Target"] as? String ?? ""
            
            completion(user)
        }) { (err) in
            print("Failed!!")
        }
        
    }
}

