//
//  EveryDays.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2016/9/22.
//  Copyright © 2016年 ChenZheng-Yang. All rights reserved.
//

import Foundation

    var themes: [ThemeModel]?
        func customClassMapping() -> [String : String]? {
        return ["themes" : "\(ThemeModel.self)"]
    }

/// 幫助model
class ThemeModel: NSObject {
    /// 幫助的url網址
    var themeurl: String?
    /// 圖片url
    var img: String?
    /// cell主標題
    var title: String?
    /// 是否有web地址 1是有, 0没有
    var hasweb: Int = -1
    /// cell的副標題
    var keywords: String?
    /// 幫助的編號
    var id: Int = -1
    var text: String?
    
}

/// 幫助
class ThemeModels: NSObject, DictModelProtocol {
    var lastdate: String?
    var list: [ThemeModel]?
    
    class func loadThemesData(completion: (data: ThemeModels?, error: NSError?)->()) {
        let path = NSBundle.mainBundle().pathForResource("themes", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        if data != nil {
            let dict: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)) as! NSDictionary
            let modelTool = DictModelManager.sharedManager
            let data = modelTool.objectWithDictionary(dict, cls: ThemeModels.self) as? ThemeModels
            
            completion(data: data, error: nil)
            
        }
    }
    
    static func customClassMapping() -> [String : String]? {
        return ["list" : "\(ThemeModel.self)"]
    }
}
