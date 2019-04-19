//
//  circleimage.swift
//  MySocialApp
//
//  Created by Khaled Bohout on 2/24/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import UIKit

class circleimage: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {

        layer.cornerRadius = self.frame.width / 2
        

    }



}
