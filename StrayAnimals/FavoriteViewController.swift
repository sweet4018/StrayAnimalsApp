//
//  FavoriteViewController.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2016/9/21.
//  Copyright © 2016年 ChenZheng-Yang. All rights reserved.
//

import UIKit
import CoreData
import SVProgressHUD

let favorteTableViewCellID = "FavoriteCell"

class FavoriteViewController: BaseViewController  {

    // MARK: 屬性
    var animalsArr:[Animal] = []
    
    weak var favoriteTableView: UITableView?
    
    let coreDataTool = CoreDataConnect()
    
    // MARK:- ViewController生命週期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNav()
        setTableView()
        refreshData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        refreshData()
    }
    
    // MARK: 設置導航列
    private func setNav() {
        
        navigationItem.title = "最愛"
        
    }
    
    // MARK: 設置表格
    private func setTableView() {
        
        let tableView = UITableView(frame: view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = ZYWhileColor()
        tableView.separatorColor = UIColor.clearColor()
        setTableViewHeader(self, refreshingAction:#selector(FavoriteViewController.pullLoadFavTableView), imageFrame: CGRectMake((ScreenWidth - SD_RefreshImage_Width) * 0.5, 10, SD_RefreshImage_Width, SD_RefreshImage_Height), tableView: tableView)
        
        let nib = UINib(nibName: String(FavoriteTableViewCell), bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: favorteTableViewCellID)
        self.view.addSubview(tableView)
        self.favoriteTableView = tableView
    }
    
    // MARK: 資料處理
    private func refreshData() {
        
        animalsArr.removeAll()
        
        let searchResult = coreDataTool.fetch(coreDataEntityAnimal, predicate: nil, sort: nil, limit: nil)
        
        if let results = searchResult {
            for result in results {
                animalsArr.append(result)
            }
            favoriteTableView?.reloadData()
        }
    }
    
    // MARK: 下拉刷新
    private func setTableViewHeader(refreshingTarget: AnyObject, refreshingAction: Selector, imageFrame: CGRect, tableView: UITableView) {
        let header = RefreshHeader(refreshingTarget: refreshingTarget, refreshingAction: refreshingAction)
        header.gifView!.frame = imageFrame
        tableView.mj_header = header
    }
    
    func pullLoadFavTableView() {
        
        weak var tmpSelf = self
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(1.0 * Double(NSEC_PER_SEC)))
        SVProgressHUD.showWithStatus("正在加載中...")
        
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            self.refreshData()
            SVProgressHUD.dismiss()
            tmpSelf?.favoriteTableView?.mj_header.endRefreshing()
        }
        
    }
}
 
 
extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return animalsArr.count ?? 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = favoriteTableView?.dequeueReusableCellWithIdentifier(favorteTableViewCellID, forIndexPath: indexPath) as! FavoriteTableViewCell
        
        cell.animal = animalsArr[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let animalDetailVC = HomeDetailViewController()
        animalDetailVC.title = "動物詳情"
        animalDetailVC.isFavoriteBtnSelect = true
        
        let oneAnimal = animalsArr[indexPath.row]
        
        var dict: Dictionary = [String:AnyObject]()
        dict["album_file"] = oneAnimal.imageURL
        dict["animal_id"] = oneAnimal.id
        dict["animal_subid"] = oneAnimal.subID
        dict["shelter_name"] = oneAnimal.name
        dict["shelter_address"] = oneAnimal.address
        dict["shelter_tel"] = oneAnimal.tel
        dict["animal_bodytype"] = oneAnimal.type
        dict["animal_sex"] = oneAnimal.sex
        dict["animal_colour"] = oneAnimal.color
        dict["animal_age"] = oneAnimal.age
        dict["animal_foundplace"] = oneAnimal.foundPlace
        dict["animal_sterilization"] = oneAnimal.sterilization
        dict["animal_bacterin"] = oneAnimal.bacterin
        dict["animal_remark"] = oneAnimal.remark
        dict["cDate"] = oneAnimal.update
        dict["animal_createtime"] = oneAnimal.createTime
        dict["animal_area_pkid"] = oneAnimal.area
        
        let aAnimal = Animals(dict: dict)
        animalDetailVC.animals = aAnimal
        navigationController?.pushViewController(animalDetailVC, animated: true)
    }
    
}