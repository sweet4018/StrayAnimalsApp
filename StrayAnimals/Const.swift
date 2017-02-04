//
//  Const.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2016/9/20.
//  Copyright © 2016年 ChenZheng-Yang. All rights reserved.
//

import UIKit

///第一次啟動
let firstLuanch = "firstLuanch"
///導引畫面數量
let NewFeatureCount = 4
///螢幕高度
let ScreenHeight : CGFloat = UIScreen.mainScreen().bounds.size.height
///螢幕寬度
let ScreenWidth : CGFloat = UIScreen.mainScreen().bounds.size.width
///Navigation高度
let NavigationH: CGFloat = 64
/// 是否登入
let isLogin = "isLogin"
///表格高度
public let DetailCellHeight : CGFloat = 50

///主螢幕
public let MainBounds: CGRect = UIScreen.mainScreen().bounds

struct theme {
    /// ViewController的背景顏色
    static let BackgroundColor: UIColor = UIColor.colorWith(255, green: 255, blue: 255, alpha: 1)
    ///  APP導航列barButtonItem文字大小
    static let NavItemFont: UIFont = UIFont.systemFontOfSize(16)
    ///  APP導航列titleFont文字大小
    static let NavTitleFont: UIFont = UIFont.systemFontOfSize(18)
    ///UIApplication.sharedApplication
    static let appShare = UIApplication.sharedApplication()
}

/// RGBA的顏色設置
func ZYColor(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}
/// 背景灰色
func ZYGrayColor() -> UIColor {
    return ZYColor(240, g: 240, b: 240, a: 1)
}
///白色
func ZYWhileColor() -> UIColor {
    return ZYColor(255, g:255 , b:255 , a:1)
}
///黑色
func ZYBlackColor() -> UIColor {
    return ZYColor(0, g: 0, b: 0, a: 1)
}

/// 線寬
let klineWidth: CGFloat = 1.0
/// 間距
let kMargin: CGFloat = 10.0
///RefreshImage高度
public let SD_RefreshImage_Height: CGFloat = 40
///RefreshImage寬度
public let SD_RefreshImage_Width: CGFloat = 35

/// 動畫時長
let kAnimationDuration = 0.25



