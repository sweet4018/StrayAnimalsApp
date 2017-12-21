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
let NavigationH: CGFloat = UIDevice().isiPhoneX() ? 131:64
///Tabbar高度
let TabbarH: CGFloat = UIDevice().isiPhoneX() ? 83:49
/// 是否登入
let isLogin = "isLogin"
///表格高度
public let DetailCellHeight : CGFloat = 50
///CoreData Entity Name 
let coreDataEntityAnimal = "Animal"


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
    ///catche文件路徑
    static let cachesPath: String = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true).last!
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

/// 分類界面 頂部 item 的高
let kitemH: CGFloat = 75
/// 分類界面 頂部 item 的寬
let kitemW: CGFloat = 150

/// 城市陣列
let cityArr: [String] = ["全部","臺北市","新北市","基隆市","宜蘭縣", "桃園縣","新竹縣", "新竹市", "苗栗縣", "臺中市","彰化縣","南投縣","雲林縣", "嘉義市", "嘉義縣", "臺南市","高雄市","屏東縣","花蓮縣","臺東縣","澎湖縣", "金門縣", "連江縣"]

/// 收容所陣列
let shelterArr: [String] = ["全部","基隆市政府動物保護防疫所寵物銀行","臺北市動物之家","新北市板橋動物之家","新北市新店動物之家","新北市新莊動物之家","新北市中和動物之家","新北市三峽動物之家","新北市淡水動物之家","新北市瑞芳動物之家","新北市五股動物之家","新北市八里動物之家","新北市三芝動物之家","桃園市動物保護教育園區","新竹市動物收容所","新竹縣動物收容所","苗栗縣北區動物收容中心(竹南鎮公所)","苗栗縣苗中區動物收容中心(苗栗市公所)","苗栗縣南區動物收容中心(苑裡鎮公所)","臺中市南屯園區動物之家","臺中市后里園區動物之家","彰化縣流浪狗中途之家","南投縣公立動物收容所","嘉義市流浪犬收容中心","嘉義縣流浪犬中途之家","臺南市灣裡站動物之家","臺南市善化站動物之家","高雄市壽山站動物保護教育園區","高雄市燕巢站動物保護教育園區","屏東縣流浪動物收容所","宜蘭縣流浪動物中途之家","花蓮縣流浪犬中途之家","臺東縣流浪動物收容中心","連江縣流浪犬收容中心","金門縣動物收容中心","澎湖縣流浪動物收容中心","雲林縣動植物防疫所","臺中市愛心小站","臺中市中途動物醫院","新北市政府動物保護防疫處","新北市金山動物之家"]

/// 體型陣列
let bodyTypeArr: [String] = ["全部","迷你","小型","中型","大型"]

/// 性別陣列
let genderArr: [String] = ["全部","公","母","未輸入"]

/// 類型陣列
let kindArr: [String] = ["全部","狗","貓","鳥"]

/// 年紀陣列
let ageArr: [String] = ["全部","幼年","成年"]

/// 絕育
let sterilizationArr: [String] = ["全部","是","否","未輸入"]

/// 疫苗
let bacterinArr: [String] = ["全部","是","否","未輸入"]

/// 類型1
let type1Arr = [bodyTypeArr,genderArr,kindArr]

/// 類型2
let type2Arr = [ageArr,sterilizationArr,bacterinArr]
