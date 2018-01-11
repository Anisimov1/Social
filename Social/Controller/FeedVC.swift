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

class FeedVC: UIViewController, UITableViewDelegate,UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageAdd: CircleView!
    
    var posts = [Post]() //array to store posts
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
    super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true //allows to crop image
        imagePicker.delegate = self
        
        //initialize listeners and getting data from Firebase
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            //print(snapshot.value) shows in output in JSON
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key //key is the data
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                    }
                }
            }
            self.tableView.reloadData() //refreshes data (need this)
        })
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let post = posts[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
            cell.configureCell(post: post)
            return cell
        } else {
            return PostCell()
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            imageAdd.image = image
        } else {
            print("TONY: a valid image wasnt selected")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addImageTapped(_ sender: Any) {
   
        present(imagePicker,animated: true, completion: nil)
    }
    @IBAction func signOutPressed(_ sender: Any) {
        let _ = KeychainWrapper.standard.remove(key: Key_UID)
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "signOut", sender: nil)
    }
}
