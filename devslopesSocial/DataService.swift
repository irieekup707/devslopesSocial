//
//  DataService.swift
//  devslopesSocial
//
//  Created by Ryan  Martino on 6/8/17.
//  Copyright © 2017 Ryan  Martino. All rights reserved.
//

import Foundation
import Firebase
import SwiftKeychainWrapper

let DB_BASE = Database.database().reference()
let STORAGE_BASE = Storage.storage().reference()

class DataService {
    
    static let ds = DataService()

    // DB references
    private var _REF_BASE = DB_BASE
    private var _REF_POST = DB_BASE.child("post")
    private var _REF_USERS = DB_BASE.child("users")
    
    // Storage references
    private var _REF_POST_IMAGES = STORAGE_BASE.child("post-pics")
    
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_POST: DatabaseReference {
        return _REF_POST
    }
    var REF_USERS: DatabaseReference {
        return _REF_USERS
        
    }
    
    var REF_USER_CURRENT: DatabaseReference {
        let uid = KeychainWrapper.standard.string(forKey: KEY_UID)
        let user = REF_USERS.child(uid!)
        return user
    }
//    
//    var REF_USER_CURRENT: DatabaseReference {
//        let uid = KeychainWrapper.string(KEY_UID)
//        let user = REF_USERS.child(uid!)
//        return user
//    }
    
    var REF_Post_Images: StorageReference {
        return _REF_POST_IMAGES
    }
    
    func createFirbaseDBUser(uid:String, userData: Dictionary<String, String>) {
        REF_USERS.child(uid).updateChildValues(userData)
        
    }
    
}
