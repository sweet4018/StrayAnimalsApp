//
//  ClassifyViewController.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2016/9/21.
//  Copyright © 2016年 ChenZheng-Yang. All rights reserved.
//

import UIKit

let classifyCollectionCellID = "ClassifyCollectionViewCell"

class ClassifyHeaderViewController: BaseViewController {
    
    var collections = [ZYCollection]()
    
    var collectionView: UICollectionView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ZYWhileColor()
        
//        setupUI()
        
    }
    
    // 设置 UI
    private func setupUI() {
        
        let headerView = NSBundle.mainBundle().loadNibNamed(String(TopHeaderView), owner: nil, options: nil).last as! TopHeaderView
        headerView.frame = CGRectMake(0, 0, ScreenWidth, 40)
        headerView.delegate = self
        view.addSubview(headerView)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .Horizontal
        let collectionView = UICollectionView(frame: CGRectMake(0, 40, ScreenWidth, 95), collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.whiteColor()
        let cellNib = UINib(nibName: String(ClassifyCollectionViewCell), bundle: nil)
        collectionView.registerNib(cellNib, forCellWithReuseIdentifier: classifyCollectionCellID)
        view.addSubview(collectionView)
        self.collectionView = collectionView
    }
}



extension ClassifyHeaderViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, TopHeaderViewDelegate {
    
    // MARK: - YMTopHeaderViewDelegate
    func topViewDidClickedMoreButton(button: UIButton) {
//        let seeAllVC = YMSeeAllController()
//        seeAllVC.title = "查看全部"
//        navigationController?.pushViewController(seeAllVC, animated: true)
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collections.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(classifyCollectionCellID, forIndexPath: indexPath) as! ClassifyCollectionViewCell
        cell.collection = collections[indexPath.item]
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        let collectionDetailVC = YMCollectionDetailController()
//        let collection = collections[indexPath.row]
//        collectionDetailVC.title = collection.title
//        collectionDetailVC.id = collection.id
//        collectionDetailVC.type = "专题合集"
//        navigationController?.pushViewController(collectionDetailVC, animated: true)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(kitemW, kitemH)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(kMargin, kMargin, kMargin, kMargin)
    }
}
