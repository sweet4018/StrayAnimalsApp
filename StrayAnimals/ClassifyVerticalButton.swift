//
//  ClassifyVerticalButton.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2017/10/15.
//  Copyright © 2017年 ChenZheng-Yang. All rights reserved.
//

import UIKit
import Kingfisher

class ClassifyVerticalButton: UIButton {

    var classifyBtnModel: BaseClassify? {
        didSet {
            
            titleLabel?.text = classifyBtnModel!.title
            imageView?.image = UIImage(named: classifyBtnModel!.imageName)
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
        
        imageView?.x = 10
        imageView?.y = 0
        imageView?.width = self.width - 20
        imageView?.height = imageView!.width
        
        titleLabel?.x = 0
        titleLabel?.y = imageView!.height
        titleLabel?.width = self.width
        titleLabel?.height = self.height - self.titleLabel!.y        
    }
}