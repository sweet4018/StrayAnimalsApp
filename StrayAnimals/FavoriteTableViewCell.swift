//
//  FavoriteTableViewCell.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2017/10/7.
//  Copyright © 2017年 ChenZheng-Yang. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var titleLb: UILabel!
    
    @IBOutlet weak var subtitleLb: UILabel!
    
    var animal: Animal? {
        didSet {
            
            if let imageData = animal?.image {
            
                let image: UIImage = UIImage(data: imageData)!
                mainImageView.image = image
            }
            
            titleLb.text = animal?.name
            if let updateTime = animal?.update {
                subtitleLb.text = "更新時間:" + updateTime
            }else {
                subtitleLb.text = "更新時間:未更新"
            }
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func setUI() {
        
        mainView.layer.shadowRadius = 10
        mainView.layer.shadowOpacity = 0.3
        mainView.layer.shadowOffset = CGSizeMake(-2, 3)
        
        mainImageView.layer.masksToBounds = true
        mainImageView.layer.cornerRadius = 10
        
        titleLb.adjustsFontSizeToFitWidth = true
        subtitleLb.adjustsFontSizeToFitWidth = true
    }
}
