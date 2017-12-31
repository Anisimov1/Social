//
//  ViewController.swift
//  Social
//
//  Created by Anthony Anisimov on 12/26/17.
//  Copyright © 2017 Anthony Anisimov. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase
import SwiftKeychainWrapper


class SignInVC: UIViewController {

    @IBOutlet weak var email: FancyField!
    @IBOutlet weak var password: FancyField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
//cant perform segues viewDidAppear can
        }
    
        override func viewDidAppear(_ animated: Bool) {
            if let _ = KeychainWrapper.standard.string(forKey: Key_UID) {
                performSegue(withIdentifier: "goToFeed", sender: nil) //if finds keychain string then go to segue, if not carry on as normal
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func facebookBtnPressed(_ sender: AnyObject) {
        //check in FB to make sure everythings ok
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("TONY: Unable to authenticate with Facebook - \(String(describing: error))")
            } else if result?.isCancelled == true {
                print("TONY: User cancelled FB authentication")
            } else {
                print("TONY: Successfully authenticated with FB")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential) //passing to next func
            }

        }
    }
    func firebaseAuth(_ credential: AuthCredential) {
        //Firebase Authentication
        Auth.auth().signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("TONY: Unable to authenticate with Firebase - \(String(describing: error))")
            } else {
                print("TONY: Successfully authenticated with Firebase")
                self.completeSignIn(id: Key_UID) //keychain (user.uid is same as Key_UID)
            }
        })
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        // Email authentication
        if let email = email.text, let pass = password.text {
            Auth.auth().signIn(withEmail: email, password: pass, completion: { (user, error) in
                if error == nil {
                    print("TONY: Email User authenticated with firebase")
                } else {
                    Auth.auth().createUser(withEmail: email, password: pass, completion: { (user, error) in
                        if error != nil {
                            print("TONY: Unable to authenticate with Firebase using email")
                        } else {
                            print("TONY: Successfully authenticated with Firebase")
                            self.completeSignIn(id: Key_UID) //keychain (user.uid is same as Key_UID)
                        }
                    })
                }
            } )
        }
    }
    func completeSignIn(id: String) {
        //keychain
            let keychainResult = KeychainWrapper.standard.set(id, forKey: Key_UID) //(user.uid is same as Key_UID)
        print("TONY: Data saved to keychain \(keychainResult)")
        performSegue(withIdentifier: "goToFeed", sender: nil)
    }
}

