//
//  ShopDetailContentView.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2016/9/27.
//  Copyright © 2016年 ChenZheng-Yang. All rights reserved.


import UIKit
import SVProgressHUD

class ShopDetailContentView: UIView {
    
    @IBOutlet weak private var time: UILabel!
    @IBOutlet weak private var shopName: UILabel!
    @IBOutlet weak private var phoneNumberLabel: UILabel!
    @IBOutlet weak private var adressLabel: UILabel!

    var shopDetailContentViewHeight: CGFloat = 0
    var detailModel: Animals? {
        didSet {
            shopName.text = detailModel!.name
            phoneNumberLabel.text = detailModel!.tel
            adressLabel.text = detailModel!.address
            time.text = detailModel!.createTime
        }
    }
    
    class func shopDetailContentViewFromXib() -> ShopDetailContentView {
        let shopView = NSBundle.mainBundle().loadNibNamed("ShopDetailContentView", owner: nil, options: nil).last as! ShopDetailContentView
        shopView.frame.size.width = ScreenWidth
        shopView.backgroundColor = ZYGrayColor()
        return shopView
    }
    
    @IBAction func callBtnCleck(sender: UIButton) {
        if detailModel?.tel == "" {
            return
        }
        callActionSheet.showInView(self)
    }
    
    @IBAction func mapBtnClick(sender: UIButton) {
        let mapView = MapViewController()
//        mapView.title = detailModel?.name
        mapView.model = detailModel
        let nav = NavigationController(rootViewController: mapView)
        UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(nav, animated: true, completion: nil)
    }
    
    
    /// MARK:- 懶加載屬性
    private lazy var callActionSheet: UIActionSheet = {
        let call = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: self.phoneNumberLabel.text)
        return call
        }()
    private lazy var correctActionSheet: UIActionSheet = {
        let correct = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "地址錯誤", "電話錯誤", "收容所介绍/圖片錯誤", "關門/歇業")
        return correct
        }()
}

extension ShopDetailContentView: UIActionSheetDelegate {
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if actionSheet === callActionSheet {
            if buttonIndex == 0 {
                let numURL = "tel://" + phoneNumberLabel.text!
                UIApplication.sharedApplication().openURL(NSURL(string: numURL)!)
            }
        } else if actionSheet === correctActionSheet {
            switch buttonIndex {
            case 1, 2, 3, 4: SVProgressHUD.showSuccessWithStatus("反饋成功", maskType: SVProgressHUDMaskType.Black)
            default: break
            }
        }
    }
    
}
