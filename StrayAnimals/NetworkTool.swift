//
//  NetworkTool.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2016/9/21.
//  Copyright © 2016年 ChenZheng-Yang. All rights reserved.
//

import Foundation
import SVProgressHUD
import Alamofire
import SwiftyJSON

class NetworkTool: NSObject {
    ///單例
    static let shareNetworkTool = NetworkTool()
    
    ///讀取公開資料
    func loadProductData(finished:(animals: [Animals]) -> ()) {
        SVProgressHUD.showWithStatus("正在加載...")
        let url = "http://data.coa.gov.tw/Service/OpenData/AnimalOpenData.aspx"
        Alamofire.request(.GET, url).responseJSON { (response) in
                guard response.result.isSuccess else {
                    SVProgressHUD.showErrorWithStatus("加載失敗...")
                    return
                }
                if let value = response.result.value {
                    let dict = JSON(value)
                    
                        if let items = dict.arrayObject {
                            var animalArray = [Animals]()
                            for item in items {
                                    let oneAnimal = Animals(dict: item as! [String: AnyObject])
                                    animalArray.append(oneAnimal)
                                SVProgressHUD.dismiss()
                            }
                            finished(animals: animalArray)
                        }
                }
        }
    }
 
    /// 分类界面 风格,品类
    func loadCategoryGroup(finished:(outGroups: [AnyObject]) -> ()) {
        SVProgressHUD.showWithStatus("正在加载...")

                    let path = NSBundle.mainBundle().pathForResource("themes", ofType: nil)
                    let dict = JSON(path!)
                    let code = dict["code"].intValue
                    let message = dict["message"].stringValue                    
                    SVProgressHUD.dismiss()
                    if let data = dict["data"].dictionary {
                        if let channel_groups = data["channel_groups"]?.arrayObject {
                            // outGroups 存储两个 inGroups 数组，inGroups 存储 YMGroup 对象
                            // outGroups 是一个二维数组
                            var outGroups = [AnyObject]()
                            for channel_group in channel_groups {
                                var inGroups = [ZYGroup]()
                                let channels = channel_group["channels"] as! [AnyObject]
                                for channel in channels {
                                    let group = ZYGroup(dict: channel as! [String: AnyObject])
                                    inGroups.append(group)
                                }
                                outGroups.append(inGroups)
                            }
                            finished(outGroups: outGroups)
                        }
                    }
                
        }
    }

