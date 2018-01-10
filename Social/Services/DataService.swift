//
//  DataService.swift
//  Social
//
//  Created by Anthony Anisimov on 1/9/18.
//  Copyright © 2018 Anthony Anisimov. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference() //taking url in database at top "social-565d0.firebseio.com

class DataService {
    //Singleton = single instance of a class (global)
    
    static let ds = DataService() //creates singleton
    
    private var _REF_BASE = DB_BASE
    private var _REF_POSTS = DB_BASE.child("posts")
    private var _REF_USERS = DB_BASE.child("users")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    var REF_POSTS: DatabaseReference {
        return _REF_POSTS
    }
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String> ) {
        //creating users
    
        _REF_USERS.child(uid).updateChildValues(userData) //if uid not / there doesnt exist, firebase will create....if we use setChildData it will wipe out current info
    }
}
