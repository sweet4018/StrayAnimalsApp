//
//  VertkcalButton.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2017/2/5.
//  Copyright © 2017年 ChenZheng-Yang. All rights reserved.
//

import UIKit
import Kingfisher

class VerticalButton: UIButton {

    var group: ZYGroup? {
        didSet {
            let url = group!.icon_url
            imageView?.kf_setImageWithURL(NSURL(string: url!)!)
            titleLabel?.text = group!.name
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.textAlignment = .Center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 调整图片
        imageView?.ZYx = 10
        imageView?.ZYy = 0
        imageView?.ZYWidth = self.width - 20
        imageView?.ZYHeight = imageView!.width
        // 调整文字
        titleLabel?.ZYx = 0
        titleLabel?.ZYy = imageView!.height
        titleLabel?.ZYWidth = self.width
        titleLabel?.ZYHeight = self.height - self.titleLabel!.y
    }
    
}