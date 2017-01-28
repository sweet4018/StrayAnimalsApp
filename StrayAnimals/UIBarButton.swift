
//
//  UIBarButton.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2016/9/22.
//  Copyright © 2016年 ChenZheng-Yang. All rights reserved.
//

import Foundation
import UIKit

/// 擴展UIBarButtonItem
extension UIBarButtonItem {
    /// 針對導航列右邊按鈕的自定義item
    convenience init(imageName: String, highlImageName: String, targer: AnyObject, action: Selector) {
        let button: UIButton = UIButton(type: .Custom)
        button.setImage(UIImage(named: imageName), forState: .Normal)
        button.setImage(UIImage(named: highlImageName), forState: .Highlighted)
        button.frame = CGRectMake(0, 0, 50, 44)
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10)
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
        button.addTarget(targer, action: action, forControlEvents: .TouchUpInside)
        
        self.init(customView: button)
    }
    
    /// 針對導航列右邊按钮有選中狀態的自定義item
    convenience init(imageName: String, highlImageName: String, selectedImage: String, targer: AnyObject, action: Selector) {
        let button: UIButton = UIButton(type: .Custom)
        button.setImage(UIImage(named: imageName), forState: .Normal)
        button.setImage(UIImage(named: highlImageName), forState: .Highlighted)
        button.frame = CGRectMake(0, 0, 50, 44)
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10)
        button.setImage(UIImage(named: selectedImage), forState: .Selected)
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
        button.addTarget(targer, action: action, forControlEvents: .TouchUpInside)
        
        self.init(customView: button)
    }
    
    /// 針對導航列左邊按钮的自定義item
    convenience init(leftimageName: String, highlImageName: String, targer: AnyObject, action: Selector) {
        let button: UIButton = UIButton(type: .Custom)
        button.setImage(UIImage(named: leftimageName), forState: .Normal)
        button.setImage(UIImage(named: highlImageName), forState: .Highlighted)
        button.frame = CGRectMake(0, 0, 80, 44)
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        button.addTarget(targer, action: action, forControlEvents: .TouchUpInside)
        
        self.init(customView: button)
    }
    
    
    
    /// 導航列纯文字按钮
    convenience init(title: String, titleClocr: UIColor, targer: AnyObject ,action: Selector) {
        let button = UIButton(type: .Custom)
        button.setTitle(title, forState: .Normal)
        button.setTitleColor(titleClocr, forState: .Normal)
        button.titleLabel?.font = theme.NavItemFont
        button.setTitleColor(UIColor.grayColor(), forState: .Highlighted)
        button.frame = CGRectMake(0, 0, 80, 44)
        button.titleLabel?.textAlignment = NSTextAlignment.Right
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5)
        button.addTarget(targer, action: action, forControlEvents: .TouchUpInside)
        
        self.init(customView: button)
    }
}