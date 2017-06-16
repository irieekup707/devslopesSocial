//
//  PostCell.swift
//  devslopesSocial
//
//  Created by Ryan  Martino on 6/7/17.
//  Copyright © 2017 Ryan  Martino. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {
    
    var post: Post!
    var likedRef: DatabaseReference!
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    @IBOutlet weak var likeImg: UIImageView!


    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        tap.numberOfTapsRequired = 1
        likeImg.addGestureRecognizer(tap)
        likeImg.isUserInteractionEnabled = true
        
    }
    func configureCell(post: Post, img: UIImage? = nil){
        self.post = post
        likedRef = DataService.ds.REF_USER_CURRENT.child("likes").child(post.postKey)
        self.caption.text = post.caption
        self.likesLbl.text = "\(post.likes)"
        
        if img != nil{
            self.postImg.image = img
        }else {
            let ref = Storage.storage().reference(forURL: post.imageURL)
            ref.getData(maxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    print("RYAN: UNABLE TO DOWNLOAD IMAGE FROM FIREBASE STORAGE")
                }else {
                    print("RYAN: IMAGE DOWNLOADED FROM FIREBASE STORAGE")
                    if let imgData = data {
                        if let img = UIImage(data: imgData) {
                            self.postImg.image = img
                            FeedVC.imageCache.setObject(img, forKey: post.imageURL as NSString)
                            
                        }
                    }
                    
                    
                }
                
                })
            
            }
    
        likedRef.observeSingleEvent(of: .value, with: { (snapshot ) in
            if let _ = snapshot.value as? NSNull {
                self.likeImg.image = UIImage(named: "empty-heart")
            }else {
                self.likeImg.image = UIImage(named: "filled-heart")
            }
        })
    
        
    
    
    }
    func likeTapped(sender: UITapGestureRecognizer) {
        
        likedRef.observeSingleEvent(of: .value, with: { (snapshot ) in
            if let _ = snapshot.value as? NSNull {
                self.likeImg.image = UIImage(named: "filled-heart")
                self.post.adjustLikes(addLike: true)
                self.likedRef.setValue(true)
            }else {
                self.likeImg.image = UIImage(named: "empty-heart")
                self.post.adjustLikes(addLike: false)
                self.likedRef.removeValue()
            }
        })
        
        
    }
}
