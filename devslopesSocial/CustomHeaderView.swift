//
//  CustomHeaderView.swift
//  devslopesSocial
//
//  Created by Ryan  Martino on 6/7/17.
//  Copyright © 2017 Ryan  Martino. All rights reserved.
//

import UIKit

class CustomHeaderView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: SHADOW_GREY, green: SHADOW_GREY, blue: SHADOW_GREY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }

}
