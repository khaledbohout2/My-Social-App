//
//  FancyView.swift
//  MySocial
//
//  Created by Khaled Bohout on 2/19/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import UIKit

class FancyView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: shadow_grey, green: shadow_grey, blue: shadow_grey, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.0
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }



}
