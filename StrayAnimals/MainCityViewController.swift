//
//  BaseViewController.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2016/9/21.
//  Copyright © 2016年 ChenZheng-Yang. All rights reserved.
//

import UIKit
import SVProgressHUD
import FDFullscreenPopGesture

class MainCityViewController: UIViewController {

    var cityRightBtn: TextImageButton!
    
     override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = ZYGrayColor()
        navigationController?.fd_prefersNavigationBarHidden = true
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.Custom)
        SVProgressHUD.setMinimumDismissTimeInterval(1.0)
        SVProgressHUD.setBackgroundColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.5))
        SVProgressHUD.setForegroundColor(UIColor.whiteColor())
        
        //城市選擇
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "cityChange:", name: SD_CurrentCityChange_Notification, object: nil)
        
        cityRightBtn = TextImageButton(frame: CGRectMake(0, 20, 80, 44))
        let user = NSUserDefaults.standardUserDefaults()
        if let currentCity = user.objectForKey(SD_Current_SelectedCity) as? String {
            cityRightBtn.setTitle(currentCity, forState: .Normal)
        } else {
            cityRightBtn.setTitle("全部", forState: .Normal)
        }
        
        cityRightBtn.titleLabel?.font = theme.NavItemFont
        cityRightBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        cityRightBtn.setImage(UIImage(named: "home_down"), forState: .Normal)
        cityRightBtn.addTarget(self, action: "pushcityView", forControlEvents: .TouchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cityRightBtn)

        
    }
    
     func pushcityView () {
        let cityVC = CityViewController()
        cityVC.cityName = self.cityRightBtn.titleForState(.Normal)
        let nav = NavigationController(rootViewController: cityVC)
        presentViewController(nav, animated: true, completion: nil)
    }
    
    func cityChange(noti: NSNotification) {
        if let currentCityName = noti.object as? String {
            self.cityRightBtn.setTitle(currentCityName, forState: .Normal)
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
}

// MARK: 自定義button,文字在左邊 圖片在右邊
class TextImageButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.font = theme.NavItemFont
        titleLabel?.contentMode = UIViewContentMode.Center
        imageView?.contentMode = UIViewContentMode.Left
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel?.sizeToFit()
        titleLabel?.frame = CGRectMake(-5, 0, titleLabel!.width, height)
        imageView?.frame = CGRectMake(titleLabel!.width + 3 - 5, 0, width - titleLabel!.width - 3, height)
    }
}