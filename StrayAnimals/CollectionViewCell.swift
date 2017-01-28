//
//  CollectionViewCell.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2016/9/21.
//  Copyright © 2016年 ChenZheng-Yang. All rights reserved.
//

import UIKit
import Kingfisher

//可點擊collectionViewCell
protocol ZYCollectionViewCellDelegate: NSObjectProtocol {
    func collectionViewCellDidClickedLikeButton(button: UIButton)
}

class CollectionViewCell: UICollectionViewCell {

    weak var delegate: ZYCollectionViewCellDelegate?
    
    var result: SearchResult? {
        didSet {
            let url = result!.image!
            imageView.kf_setImageWithURL(NSURL(string: url)!, placeholderImage: nil, optionsInfo: nil, progressBlock: nil) { (image, error, cacheType, imageURL) in
                self.placeholderBtn.hidden = true
            }
            titleLabel.text = result!.name
            timeLabel.text = "更新時間：" + String(result!.update!)
        }
    }
    
    var animal: Animals? {
        didSet {
            let url = animal!.image!
            imageView.kf_setImageWithURL(NSURL(string: url)!, placeholderImage: nil, optionsInfo: nil, progressBlock: nil) { (image, error, cacheType, imageURL) in
                self.placeholderBtn.hidden = true
            }
            titleLabel.text = animal!.name
            timeLabel.text = "更新時間：" + String(animal!.update!)
        }
    }

    //標題
    @IBOutlet var titleLabel: UILabel!
    //最新時間
    @IBOutlet var timeLabel: UILabel!
    //佔用圖片
    @IBOutlet var placeholderBtn: UIButton!
    //背景圖片
    @IBOutlet var imageView: UIImageView!
}
