//
//  ClassifyDetailViewController.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2017/10/15.
//  Copyright © 2017年 ChenZheng-Yang. All rights reserved.
//

import UIKit
import SVProgressHUD

class ClassifyDetailViewController: BaseViewController {

    //MARK:- 屬性
    var animalArray = [Animals]()
    
    let selectBtn: Int!  = 0
    
    var searchKeyDataDic = Dictionary<String, String>()
    
    weak var collectionView: UICollectionView?
    
    private let coreDetaTool = CoreDataConnect()
    
    var skipCount:Int = 10
    
    //MARK:- ViewController生命週期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollectionView()
        view.addSubview(self.nodataView)
        
        for (key, value) in searchKeyDataDic {
            print("字典內有\(key,value)")
        }

        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        self.skipCount = 10
        
        NetworkTool.shareNetworkTool.loadAnimalsData(0, dict: searchKeyDataDic, finished: {[weak self] (animals) in
            
            self?.nodataView.hidden = animals.count > 0
            self!.animalArray = animals
            self?.collectionView!.reloadData()
            })
    }
    
    
    //MARK:- 設置UI
    //MARK: 設置Collection
    private func setCollectionView() {
        
        let collectionView = UICollectionView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight-NavigationH-TabbarH+20), collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = ZYGrayColor()
        let nib = UINib(nibName: String(CollectionViewCell), bundle: nil)
        collectionView.registerNib(nib, forCellWithReuseIdentifier: collectionCellID)
        self.view.addSubview(collectionView)
        self.collectionView = collectionView
        setCollectionViewHeader(self, refreshingAction: #selector(ClassifyDetailViewController.pullDownLoadCollection), imageFrame: CGRectMake((ScreenWidth - SD_RefreshImage_Width) * 0.5, 10, SD_RefreshImage_Width, SD_RefreshImage_Height), tableView: collectionView)
        
        setCollectionFooter(self, refreshingAction: #selector(ClassifyDetailViewController.pullUpLoadCollection), imageFrame: CGRectMake((ScreenWidth - SD_RefreshImage_Width) * 0.5, 10, SD_RefreshImage_Width, SD_RefreshImage_Height), collection: collectionView)
        
    }
    
    private func setCollectionViewHeader(refreshingTarget: AnyObject, refreshingAction: Selector, imageFrame: CGRect, tableView: UICollectionView) {
        let header = RefreshHeader(refreshingTarget: refreshingTarget, refreshingAction: refreshingAction)
        header.gifView!.frame = imageFrame
        tableView.mj_header = header                
    }
    
    private func setCollectionFooter(refreshingTarget: AnyObject,refreshingAction: Selector, imageFrame: CGRect,collection: UICollectionView) {
        let footer = LoadFooter(refreshingTarget: refreshingTarget, refreshingAction: refreshingAction)
        footer.gifView!.frame = imageFrame
        collectionView!.mj_footer = footer
    }
    
    //下拉刷新
    func pullDownLoadCollection() {
        
        animalArray.removeAll()
        
        weak var tmpSelf = self
        // 模擬延時加載
        let time = dispatch_time(DISPATCH_TIME_NOW,Int64(1.0 * Double(NSEC_PER_SEC)))
        SVProgressHUD.showWithStatus("正在加載...")
        
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            
            NetworkTool.shareNetworkTool.loadAnimalsData(10, dict: self.searchKeyDataDic, finished: {[weak self] (animals) in
                
                
                self!.setCollectionView()
                self?.nodataView.hidden = animals.count > 0
                self!.animalArray = animals                
                self?.collectionView!.reloadData()
                tmpSelf!.collectionView!.mj_header.endRefreshing()
                })
        }
    }
    
    
    //上拉刷新
    func pullUpLoadCollection() {
        
        self.skipCount += 10
        weak var tmpSelf = self
        
        dispatch_async(dispatch_get_main_queue()) { 
            
            NetworkTool.shareNetworkTool.loadAnimalsData(self.skipCount, dict: self.searchKeyDataDic, finished: {[weak self] (animals) in
                
                self?.nodataView.hidden = animals.count > 0
                self!.animalArray += animals
                self?.collectionView!.reloadData()
                tmpSelf!.collectionView!.mj_footer.endRefreshing()
                })
        }
    }
    
    
    private lazy var nodataView: UIView = {
        let view = UIView(frame: CGRectMake(0,0,ScreenWidth,40))
        let titleLb = UILabel(frame: CGRectMake(0,0,ScreenWidth,40))
        titleLb.textAlignment = NSTextAlignment.Center
        titleLb.text = "查無資料"
        view.addSubview(titleLb)
        
        return view
    }()
}

extension ClassifyDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ZYCollectionViewCellDelegate {
    
    func collectionViewCellDidClickedLikeButton(button: UIButton) {
        
        print("點擊誰？\(button.tag)")
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animalArray.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(collectionCellID, forIndexPath: indexPath) as! CollectionViewCell
        cell.animal = animalArray[indexPath.item]
        cell.delegate = self
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let animalDetailVC = HomeDetailViewController()
        animalDetailVC.title = "動物詳情"
        
        let oneAnimal = animalArray[indexPath.item]
        let predicateName = oneAnimal.ID
        let predicate = NSPredicate(format: "id == %@", predicateName!)
        let searchResult = coreDetaTool.fetch(coreDataEntityAnimal, predicate: predicate, sort: nil, limit: nil)
        var isFavBtnSelect: Bool
        if searchResult?.count > 0 {
            isFavBtnSelect = true
        }else {
            isFavBtnSelect = false
        }
        
        animalDetailVC.isFavoriteBtnSelect = isFavBtnSelect
        animalDetailVC.animals = oneAnimal
        navigationController?.pushViewController(animalDetailVC, animated: true)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let width: CGFloat = (ScreenWidth - 20)/2
        let height: CGFloat = 245
        return CGSizeMake(width, height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 5, 5, 5)
    }
    
    
}
