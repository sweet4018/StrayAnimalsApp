//
//  ClassifyViewController.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2016/9/21.
//  Copyright © 2016年 ChenZheng-Yang. All rights reserved.
//

import UIKit

class ClassifyHeaderViewController: BaseViewController {
    
    var collections = [ZYCollection]()
    
    var collectionView: UICollectionView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ZYWhileColor()
        
        setupUI()
    }
    
    // 设置 UI
    private func setupUI() {
        
        let headerView = NSBundle.mainBundle().loadNibNamed(String(TopHeaderView), owner: nil, options: nil).last as! TopHeaderView
        headerView.frame = CGRectMake(0, 0, ScreenWidth, 40)
//        headerView.delegate = self
        view.addSubview(headerView)
        
        //        let flowLayout = UICollectionViewFlowLayout()
        //        flowLayout.scrollDirection = .Horizontal
        //        let collectionView = UICollectionView(frame: CGRectMake(0, 40, ScreenWidth, 95), collectionViewLayout: flowLayout)
        //        collectionView.delegate = self
        //        collectionView.dataSource = self
        //        collectionView.showsHorizontalScrollIndicator = false
        //        collectionView.backgroundColor = UIColor.whiteColor()
        //        let cellNib = UINib(nibName: String(YMCategoryCollectionViewCell), bundle: nil)
        //        collectionView.registerNib(cellNib, forCellWithReuseIdentifier: categoryCollectionCellID)
        //        view.addSubview(collectionView)
        //        self.collectionView = collectionView
    }
    
    
}