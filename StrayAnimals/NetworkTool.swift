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
 
    
    
    
    
    
    
    
    
    
    
    
    
    
}

