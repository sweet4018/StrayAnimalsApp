//
//  CityViewController.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2016/9/22.
//  Copyright © 2016年 ChenZheng-Yang. All rights reserved.
//

import UIKit

public let SD_Current_SelectedCity = "SD_Current_SelectedCity"
public let SD_CurrentCityChange_Notification = "SD_CurrentCityChange_Notification"

class CityViewController: UIViewController {

    var cityName: String?
    var collView: UICollectionView!
    var layout = UICollectionViewFlowLayout()
    
    lazy var domesticCitys: NSMutableArray? = {
        let arr = NSMutableArray(array: ["全部","臺北", "桃園", "新竹", "苗栗", "臺中", "彰化", "雲林", "嘉義", "臺南","高雄","屏東","臺東","花蓮","宜蘭"])
        return arr
    }()
    lazy var overseasCitys: NSMutableArray? = {
        let arr = NSMutableArray(array: ["馬祖", "澎湖", "金門", "綠島", "小琉球", "蘭嶼"])
        return arr
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNav()
        
        setCollectionView()
        
        let lastSelectedCityIndexPaht = selectedCurrentCity()
        collView.selectItemAtIndexPath(lastSelectedCityIndexPaht, animated: true, scrollPosition: UICollectionViewScrollPosition.None)
    }
    
    private func selectedCurrentCity() -> NSIndexPath {
        if let currentCityName = self.cityName {
            for var i = 0; i < domesticCitys!.count; i++ {
                if currentCityName == domesticCitys![i] as! String {
                    return NSIndexPath(forItem: i, inSection: 0)
                }
            }
            
            for var i = 0; i < overseasCitys!.count; i++ {
                if currentCityName == overseasCitys![i] as! String {
                    return NSIndexPath(forItem: i, inSection: 1)
                }
            }
        }
        return NSIndexPath(forItem: 0, inSection: 0)
    }
    
    func setNav() {
        view.backgroundColor = theme.BackgroundColor
        navigationItem.title = "選擇城市"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .Done, target: self, action: "cancle")
    }
    
    func setCollectionView() {
        // 設置布局
        let itemW = ScreenWidth / 3.0 - 1.0
        let itemH: CGFloat = 50
        layout.itemSize = CGSizeMake(itemW, itemH)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.headerReferenceSize = CGSizeMake(view.width, 60)
        
        // 設置collectionView
        collView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collView.delegate = self
        collView.dataSource = self
        collView.selectItemAtIndexPath(NSIndexPath(forItem: 1, inSection: 0), animated: true, scrollPosition: UICollectionViewScrollPosition.None)
        collView.backgroundColor = UIColor.colorWith(247, green: 247, blue: 247, alpha: 1)
        collView.registerClass(CityCollectionViewCell.self, forCellWithReuseIdentifier: "cellID")
        collView.registerClass(CityHeadCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headView")
        collView.registerClass(CityFootCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footView")
        collView.alwaysBounceVertical = true
        view.addSubview(collView!)
    }
    
    func cancle() {
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
}



// MARK - UICollectionViewDelegate, UICollectionViewDataSource
extension CityViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return domesticCitys!.count
        } else {
            return overseasCitys!.count
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collView.dequeueReusableCellWithReuseIdentifier("cellID", forIndexPath: indexPath) as! CityCollectionViewCell
        if indexPath.section == 0 {
            cell.cityName = domesticCitys!.objectAtIndex(indexPath.row) as? String
        } else {
            cell.cityName = overseasCitys!.objectAtIndex(indexPath.row) as? String
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionFooter && indexPath.section == 1 {
            let footView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter, withReuseIdentifier: "footView", forIndexPath: indexPath) as! CityFootCollectionReusableView
            footView.frame.size.height = 80
            return footView
        }
        
        let headView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "headView", forIndexPath: indexPath) as! CityHeadCollectionReusableView
        
        if indexPath.section == 0 {
            headView.headTitle = "本島城市"
        } else {
            headView.headTitle = "離島城市"
        }
        
        return headView
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // 拿出當前選擇的cell
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CityCollectionViewCell
        let currentCity = cell.cityName
        let user = NSUserDefaults.standardUserDefaults()
        user.setObject(currentCity, forKey: SD_Current_SelectedCity)
        if user.synchronize() {
            NSNotificationCenter.defaultCenter().postNotificationName(SD_CurrentCityChange_Notification, object: currentCity)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    /// 這方法是UICollectionViewDelegateFlowLayout協議裡面的，我現在是默認的流佈局，沒有自定義佈局，所以就沒有實現UICollectionViewDelegateFlowLayout協議，需要完全手敲出來方法，對應的也有設置頭的尺寸方法
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSizeZero
        } else {
            return CGSizeMake(view.width, 120)
        }
    }
    
}


