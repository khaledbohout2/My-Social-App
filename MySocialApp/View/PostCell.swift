//
//  PostCell.swift
//  MySocialApp
//
//  Created by Khaled Bohout on 2/24/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import UIKit

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
    
    func configurecell(post:Post){
        self.post = post
        self.captionlbl.text = post.caption
        self.likeslbl.text = "\(post.likes)"
    }
}
