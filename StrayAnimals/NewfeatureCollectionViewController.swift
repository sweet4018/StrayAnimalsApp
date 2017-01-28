//
//  NewfeatureCollectionViewController.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2016/9/20.
//  Copyright © 2016年 ChenZheng-Yang. All rights reserved.
//

import UIKit
import SnapKit

let newFeatureID = "newFeatureID"

class NewfeatureCollectionViewController: UICollectionViewController {

    //佈局對象
    private var layout:UICollectionViewFlowLayout = NewfeatureLayout()
    init(){
        super.init(collectionViewLayout:layout)
        collectionView?.showsHorizontalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:)  has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.registerClass(NewfeatureCell.self, forCellWithReuseIdentifier: newFeatureID)
        buildPageController()
    }
    
    private var pageController = UIPageControl(frame: CGRectMake(0, ScreenHeight*0.2 , ScreenWidth, 20))
    
    
}

extension NewfeatureCollectionViewController {
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NewFeatureCount
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(newFeatureID, forIndexPath: indexPath) as! NewfeatureCell
        cell.imageIndex = indexPath.item
        return cell
    }
    //完全顯示一個cell後使用
    override func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let path = collectionView.indexPathsForVisibleItems().last!
        if path.item == (NewFeatureCount - 1) {
            let cell = collectionView.cellForItemAtIndexPath(path) as! NewfeatureCell
            cell.startBtnAnimation()
        }
    }
    
    private func buildPageController() {
        pageController.numberOfPages = NewFeatureCount
        pageController.currentPage = 0
        pageController.pageIndicatorTintColor = UIColor.grayColor()
        pageController.currentPageIndicatorTintColor = UIColor.blackColor()
        view.addSubview(pageController)
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        pageController.currentPage = Int(scrollView.contentOffset.x / ScreenWidth + 0.5)
    }
}

private class NewfeatureCell: UICollectionViewCell{
    
    private var imageIndex: Int? {
        didSet {
            iconView.image = UIImage(named: "walkthrough_\(imageIndex! + 1)")
        }
    }
    
    
    func startBtnAnimation() {
        startButton.hidden = false
        // 執行動畫
        startButton.transform = CGAffineTransformMakeScale(0.0, 0.0)
        startButton.userInteractionEnabled = false
        
        // UIViewAnimationOptions(rawValue: 0) == OC knilOptions
        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 5, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
            // 清空變形
            self.startButton.transform = CGAffineTransformIdentity
            }, completion: { (_) -> Void in
                self.startButton.userInteractionEnabled = true
        })
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(iconView)
        contentView.addSubview(startButton)
        
        iconView.snp_makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
        
        startButton.snp_makeConstraints { (make) in
            make.bottom.equalTo(contentView.snp_bottom).offset(-50)
            make.size.equalTo(CGSizeMake(180, 70))
            make.centerX.equalTo(0)
        }
    }
    
    private lazy var iconView = UIImageView()
    private lazy var startButton: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "btn_begin"), forState: .Normal)
        btn.addTarget(self, action: #selector(startButtonClick), forControlEvents: .TouchUpInside)
        btn.layer.masksToBounds = true
        btn.hidden = true
        return btn
    }()
    
    @objc func startButtonClick() {
        UIApplication.sharedApplication().keyWindow?.rootViewController = TabBarController()
    }
}


private class NewfeatureLayout: UICollectionViewFlowLayout {
    //準備佈局
    private override func prepareLayout() {
        // 設置layout佈局
        itemSize = UIScreen.mainScreen().bounds.size
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .Horizontal
        //設置contentView屬性
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.bounces = false
        collectionView?.pagingEnabled = true
    }
}

