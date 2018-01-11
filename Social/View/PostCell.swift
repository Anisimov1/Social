//
//  PostCell.swift
//  Social
//
//  Created by Anthony Anisimov on 12/30/17.
//  Copyright © 2017 Anthony Anisimov. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    
    var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(post: Post, img: UIImage? = nil) {
        self.post = post
        self.caption.text = post.caption
        self.likesLbl.text = "\(post.likes)"
        
        if img != nil {
            self.postImg.image = img
        } else {
                let ref = Storage.storage().reference(forURL: post.imageURL)
                ref.getData(maxSize: 2 * 1024 * 1024, completion: { (data, error) in
                    if error != nil {
                        print("TONY: Unable to download image from firebase storage")
                    } else {
                        print("TONY: IMage downloaded from firebase storage")
                        if let imgData = data {
                            if let img = UIImage(data: imgData) {
                                self.postImg.image = img
                                FeedVC.imageCache.setObject(img, forKey: post.imageURL as NSString) //getting image and saving to cache
                            }
                        }
                    }
                })
            }
        }
        
    }


