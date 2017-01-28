//
//  HomeDetailTopView.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2016/9/26.
//  Copyright © 2016年 ChenZheng-Yang. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

let detailCollectionViewCellID = "detailCollectionViewCellID"

class HomeDetailTopView: UIView {

    var imageURLs = String()
    
    var animal : Animals? {
        didSet{
            imageURLs = animal!.image!
            collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(collectionView)
        
        addSubview(pageControl)
        
        pageControl.snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(collectionView.snp_bottom).offset(-30)
        }
      
    }

    private lazy var collectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: CGRectMake(0, 0, ScreenWidth, ScreenWidth), collectionViewLayout: DetailLayout())
        let nib = UINib(nibName: String(HomeDetailCollectionViewCell), bundle: nil)
        collectionView.registerNib(nib, forCellWithReuseIdentifier: detailCollectionViewCellID)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.whiteColor()
        return collectionView
    }()
    
    
    /// 懒加载，pageControl
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.whiteColor()
        pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        return pageControl
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private class DetailLayout: UICollectionViewFlowLayout {
        /// 準備佈局
        private override func prepareLayout() {
            // 設置 layout 佈局
            itemSize = CGSizeMake(ScreenWidth, 375)
            minimumLineSpacing = 0
            minimumInteritemSpacing = 0
            scrollDirection = .Horizontal
            // 設置 contentView 屬性
            collectionView?.showsHorizontalScrollIndicator = false
            collectionView?.showsVerticalScrollIndicator = false
            collectionView?.bounces = false
            collectionView?.pagingEnabled = true
        }
    }
}
    
extension HomeDetailTopView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(detailCollectionViewCellID, forIndexPath: indexPath) as! HomeDetailCollectionViewCell
        let url = imageURLs
        cell.bgImageView.kf_setImageWithURL(NSURL(string: url)!, placeholderImage: nil, optionsInfo: nil, progressBlock: nil) { (image, error, cacheType, imageURL) in
            cell.placeholderButton.hidden = true
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let page = offsetX / scrollView.width
        pageControl.currentPage = Int(page + 0.5)
    }
    
}


