//
//  ScoailItemCell.swift
//  ZoomingIcons
//
//  Created by xjc on 16/8/7.
//  Copyright © 2016年 xjc. All rights reserved.
//

import UIKit

class ScoailItemCell: UICollectionViewCell {
    
    @IBOutlet weak var coloredView: UIView!
    @IBOutlet weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        coloredView.layer.cornerRadius = self.bounds.width/2.0
        coloredView.layer.masksToBounds = true 
    }

}
