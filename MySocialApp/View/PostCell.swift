//
//  PostCell.swift
//  MySocialApp
//
//  Created by Khaled Bohout on 2/24/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profileimg: UIImageView!
    @IBOutlet weak var usernamelbl: UILabel!
    @IBOutlet weak var captionlbl: UITextView!
    @IBOutlet weak var postimg: UIImageView!
    @IBOutlet weak var likeslbl: UILabel!
    @IBOutlet weak var likesimage: UIImageView!
    
    var post:Post!
    var likes_Ref:DatabaseReference!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action:#selector (liketapped))
        tap.numberOfTapsRequired = 1
        likesimage.addGestureRecognizer(tap)
        likesimage.isUserInteractionEnabled = true
    }
    
    func configurecell(post:Post,img:UIImage? = nil){
        
        self.post = post
        likes_Ref = DataService.ds.Ref_User_Current.child("likes").child(post.postkey)
        self.captionlbl.text = post.caption
        self.likeslbl.text = "\(post.likes)"
        
        if img != nil{
            self.postimg.image = img
        }
        else {
            let ref = Storage.storage().reference(forURL: post.imageurl)
            ref.getData(maxSize: 2 * 1021 * 1024 , completion:  {(data, error) in 
                if error != nil {
                print("khaled: unable to download image from firebase storage")
                }
                else{
                print ("image downloaded from firebase storage")
                    if let imgdata = data {
                        if let img = UIImage(data: imgdata){
                            self.postimg.image = img
                            FeedVC.imagecash.setObject(img, forKey: post.imageurl as NSString)
                        }
                    }
                }
            })
    }
        likes_Ref.observeSingleEvent(of: .value,with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.likesimage.image = UIImage(named: "empty-heart")
            } else{
                self.likesimage.image = UIImage(named: "filled-heart")
                
            }
        })
}
    @objc func liketapped(sender: UITapGestureRecognizer){
        
        likes_Ref.observeSingleEvent(of:.value,with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.likesimage.image = UIImage(named: "filled-heart")
                self.post.adjustlike(addlike: true)
                self.likes_Ref.setValue(true)
            } else{
                self.likesimage.image = UIImage(named: "empty-heart")
                self.post.adjustlike(addlike: false)
                self.likes_Ref.removeValue()
                
            }
        })
        
    }
}
