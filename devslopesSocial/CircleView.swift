//
//  CircleView.swift
//  devslopesSocial
//
//  Created by Ryan  Martino on 6/7/17.
//  Copyright © 2017 Ryan  Martino. All rights reserved.
//

import UIKit

class CircleView: UIImageView {
    
    override func layoutSubviews() {
        
        layer.cornerRadius = self.frame.width / 2
        
    }
}
