//
//  DataService.swift
//  devslopesSocial
//
//  Created by Ryan  Martino on 6/8/17.
//  Copyright © 2017 Ryan  Martino. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

class DataService {
    
    static let ds = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_POST = DB_BASE.child("posts")
    private var _REF_USERS = DB_BASE.child("users")
    
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_POST: DatabaseReference {
        return _REF_POST
    }
    var REF_USERS: DatabaseReference {
        return _REF_USERS
        
    }
    func createFirbaseDBUser(uid:String, userData: Dictionary<String, String>) {
        REF_USERS.child(uid).updateChildValues(userData)
        
    }
    
}
