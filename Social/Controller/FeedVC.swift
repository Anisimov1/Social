//
//  FeedVC.swift
//  Social
//
//  Created by Anthony Anisimov on 12/29/17.
//  Copyright © 2017 Anthony Anisimov. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController {
    override func viewDidLoad() {
    
    }
 
    @IBAction func signOutPressed(_ sender: Any) {
        let _ = KeychainWrapper.standard.remove(key: Key_UID)
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "signOut", sender: nil)
    }
}
