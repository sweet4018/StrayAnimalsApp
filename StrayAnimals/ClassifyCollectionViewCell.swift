//
//  ClassifyCollectionViewCell.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2017/2/5.
//  Copyright © 2017年 ChenZheng-Yang. All rights reserved.
//

import UIKit

class ClassifyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var collectionImageView: UIImageView!
    
    @IBOutlet weak var placeholderButton: UIButton!
    
    var collection: ZYCollection? {
        didSet {
            let url = collection!.banner_image_url
            collectionImageView.kf_setImageWithURL(NSURL(string: url!)!, placeholderImage: nil, optionsInfo: nil, progressBlock: nil) { (image, error, cacheType, imageURL) in
                self.placeholderButton.hidden = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
