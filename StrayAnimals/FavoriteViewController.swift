//
//  FavoriteViewController.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2016/9/21.
//  Copyright © 2016年 ChenZheng-Yang. All rights reserved.
//

import UIKit
import SVProgressHUD


class FavoriteViewController: MainCityViewController , DoubleTextViewDelegate {

    var animalsArray = [Animals]()
    
    weak var collectionView : UICollectionView?
    
    private var backgroundScrollView: UIScrollView!
    private var doubleTextView: DoubleTextView!
    private var everyDays: EveryDays?
    private var albumTableView: MainTableView!
    private var dayTableView: MainTableView!
    private var themes: ThemeModels?
    private var events: EveryDays?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkTool.shareNetworkTool.loadProductData { [weak self] (animals) in
            self!.animalsArray = animals
            self?.collectionView!.reloadData()
        }
        
        // 初始化导航条内容
        setNav()
        
        // 设置scrollView
        setScrollView()
        
        //設置collectionView
        setupCollectionView()
        
        // 初始化美天tablieView
        setdayTableView()
        
        // 初始化美辑tableView
//        setalbumTableView()
        
        // 下拉加载数据
        dayTableView.mj_header.beginRefreshing()
//        albumTableView.mj_header.beginRefreshing()
        
    }
    
    /// 設置collectionView
    private func setupCollectionView() {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.backgroundColor = ZYGrayColor()
        collectionView.dataSource = self
        let nib = UINib(nibName: String(CollectionViewCell), bundle: nil)
        collectionView.registerNib(nib, forCellWithReuseIdentifier: collectionCellID)
        backgroundScrollView.addSubview(collectionView)
        self.collectionView = collectionView
        setCollectionViewHeader(self, refreshingAction: #selector(HomeViewController.pullLoadAlbumData), imageFrame: CGRectMake((ScreenWidth - SD_RefreshImage_Width) * 0.5, 10, SD_RefreshImage_Width, SD_RefreshImage_Height), tableView: collectionView)
        
    }
    
    private func setCollectionViewHeader(refreshingTarget: AnyObject, refreshingAction: Selector, imageFrame: CGRect, tableView: UICollectionView) {
        let header = RefreshHeader(refreshingTarget: refreshingTarget, refreshingAction: refreshingAction)
        header.gifView!.frame = imageFrame
        tableView.mj_header = header
    }
    
    //-------------------
    
    
    private func setScrollView() {
        self.automaticallyAdjustsScrollViewInsets = false
        backgroundScrollView = UIScrollView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight - NavigationH - 49))
        backgroundScrollView.backgroundColor = theme.BackgroundColor
        backgroundScrollView.contentSize = CGSizeMake(ScreenWidth * 2.0, 0)
        backgroundScrollView.showsHorizontalScrollIndicator = false
        backgroundScrollView.showsVerticalScrollIndicator = false
        backgroundScrollView.pagingEnabled = true
        backgroundScrollView.delegate = self
        view.addSubview(backgroundScrollView)
    }
    
    
    
    private func setNav() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "附近", titleClocr: UIColor.blackColor(), targer: self, action: #selector(FavoriteViewController.nearClick))
        
        doubleTextView = DoubleTextView(leftText: "美天", rigthText: "美辑");
        doubleTextView.frame = CGRectMake(0, 0, 120, 44)
        doubleTextView.delegate = self
        navigationItem.titleView = doubleTextView
    }
    
    private func setdayTableView() {
        dayTableView = MainTableView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight - NavigationH), style: .Grouped, dataSource: self, delegate: self)
        dayTableView.sectionHeaderHeight = 0.1
        dayTableView.sectionFooterHeight = 0.1
        dayTableView.contentInset = UIEdgeInsetsMake(-35, 0, 35, 0)
        backgroundScrollView.addSubview(dayTableView)
        
        setTableViewHeader(self, refreshingAction: "pullLoadDayData", imageFrame: CGRectMake((ScreenWidth - SD_RefreshImage_Width) * 0.5, 47, SD_RefreshImage_Width, SD_RefreshImage_Height), tableView: dayTableView)
    }
    
    
    private func setalbumTableView() {
        albumTableView = MainTableView(frame: CGRectMake(ScreenWidth, 0, ScreenWidth, backgroundScrollView.height), style: .Plain, dataSource: self, delegate: self)
        backgroundScrollView.addSubview(albumTableView)
        
        setTableViewHeader(self, refreshingAction: "pullLoadAlbumData", imageFrame: CGRectMake((ScreenWidth - SD_RefreshImage_Width) * 0.5, 10, SD_RefreshImage_Width, SD_RefreshImage_Height), tableView: albumTableView)
    }
    
    private func setTableViewHeader(refreshingTarget: AnyObject, refreshingAction: Selector, imageFrame: CGRect, tableView: UITableView) {
        let header = RefreshHeader(refreshingTarget: refreshingTarget, refreshingAction: refreshingAction)
        header.gifView!.frame = imageFrame
        tableView.mj_header = header
    }
    
    ///MARK:- 下拉加载刷新数据
    func pullLoadDayData() {
        weak var tmpSelf = self
        // 模拟延时加载
        let time = dispatch_time(DISPATCH_TIME_NOW,Int64(0.6 * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            EveryDays.loadEventsData { (data, error) -> () in
                if error != nil {
                    SVProgressHUD.showErrorWithStatus("數據加載失敗")
                    tmpSelf!.dayTableView.mj_header.endRefreshing()
                    return
                }
                tmpSelf!.everyDays = data!
                tmpSelf!.dayTableView.reloadData()
                tmpSelf!.dayTableView.mj_header.endRefreshing()
            }
        }
    }
    
    func pullLoadAlbumData() {
        weak var tmpSelf = self
        let time = dispatch_time(DISPATCH_TIME_NOW,Int64(1.0 * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            ThemeModels.loadThemesData { (data, error) -> () in
                if error != nil {
                    SVProgressHUD.showErrorWithStatus("网络不给力")
                    tmpSelf!.albumTableView.mj_header.endRefreshing()
                    return
                }
                tmpSelf!.themes = data!
                tmpSelf!.albumTableView.reloadData()
                tmpSelf!.albumTableView.mj_header.endRefreshing()
            }
            
        }
    }
    
    
    /// 附近action
    func nearClick() {
//        let nearVC = NearViewController()
//        navigationController?.pushViewController(nearVC, animated: true)
    }
    
    // MARK: - DoubleTextViewDelegate
    func doubleTextView(doubleTextView: DoubleTextView, didClickBtn btn: UIButton, forIndex index: Int) {
        backgroundScrollView.setContentOffset(CGPointMake(ScreenWidth * CGFloat(index), 0), animated: true)
    }
}

extension FavoriteViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout, ZYCollectionViewCellDelegate {
    
    // MARK: - UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animalsArray.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(collectionCellID, forIndexPath: indexPath) as! CollectionViewCell
        cell.animal = animalsArray[indexPath.item]
        cell.delegate = self
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let productDetailVC = HomeDetailViewController()
        productDetailVC.title = "動物詳情"
        productDetailVC.animals = animalsArray[indexPath.item]
        navigationController?.pushViewController(productDetailVC, animated: true)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width: CGFloat = (UIScreen.mainScreen().bounds.width - 20) / 2
        let height: CGFloat = 245
        return CGSizeMake(width, height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 5, 5, 5)
    }
    
    // MARK: - CollectionViewCellDelegate
    func collectionViewCellDidClickedLikeButton(button: UIButton) {
        if !NSUserDefaults.standardUserDefaults().boolForKey(isLogin) {
            let loginVC = HomeDetailViewController()
            //            loginVC.title = "登入"
            let nav = NavigationController(rootViewController: loginVC)
            presentViewController(nav, animated: true, completion: nil)
        } else {
            
        }
    }
}



/// MARK: UIScrollViewDelegate
extension FavoriteViewController: UIScrollViewDelegate {
    
    // MARK: - UIScrollViewDelegate 监听scrollView的滚动事件
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView === backgroundScrollView {
            let index = Int(scrollView.contentOffset.x / ScreenWidth)
            doubleTextView.clickBtnToIndex(index)
        }
    }
}



///MARK:- UITableViewDelegate和UITableViewDataSource
extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView === albumTableView {
            return themes?.list?.count ?? 0
            
        } else {
            let event = self.everyDays!.list![section]
            if let _ = event.themes?.last {
                return 2
            }
            
            return 1
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tableView === albumTableView {
            
            return 240
        } else {
            if indexPath.row == 1 {
                return 220
            } else {
                return 253
            }
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if tableView === albumTableView {
            
            return 1
        } else {
            return self.everyDays?.list?.count ?? 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        
        if tableView === albumTableView { // 美辑TableView
            
            let theme = self.themes!.list![indexPath.row]
            
            cell = ThemeCell.themeCellWithTableView(tableView)
            (cell as! ThemeCell).model = theme
            
        }   else { // 美天TableView
            let event = self.everyDays!.list![indexPath.section]
            
            if indexPath.row == 1 {
                
                cell = ThemeCell.themeCellWithTableView(tableView)
                (cell as! ThemeCell).model = event.themes?.last
            } else {
                cell = EventCellTableViewCell.eventCell(tableView)
                (cell as! EventCellTableViewCell).eventModel = event
            }
        }
        
        return cell!
    }
    

}
 
 
