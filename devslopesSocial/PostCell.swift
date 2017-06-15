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
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likesLbl: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func configureCell(post: Post, img: UIImage? = nil){
        self.post = post
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
        
    }
}
