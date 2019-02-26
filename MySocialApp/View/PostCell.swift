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
    
    var post:Post!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configurecell(post:Post,img:UIImage? = nil){
        
        self.post = post
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
}
}
