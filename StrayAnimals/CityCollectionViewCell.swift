//
//  CityCollectionViewCell.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2016/9/22.
//  Copyright © 2016年 ChenZheng-Yang. All rights reserved.
//

import UIKit

//  選擇城市cell
class CityCollectionViewCell: UICollectionViewCell {
    
    private var textLabel: UILabel = UILabel()
    
    var cityName: String? {
        didSet {
            textLabel.text = cityName
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textLabel.textColor = UIColor.blackColor()
        textLabel.highlightedTextColor = UIColor.redColor()
        textLabel.textAlignment = .Center
        textLabel.backgroundColor = UIColor.whiteColor()
        contentView.addSubview(textLabel)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 重新布局子控件
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel.frame = self.bounds
    }
}

