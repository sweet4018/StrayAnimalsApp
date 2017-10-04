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
    
    let baseURL = "http://data.coa.gov.tw/Service/OpenData/AnimalOpenData.aspx";
    
    let cityArr: [String] = ["全部","臺北市","新北市","基隆市","宜蘭縣", "桃園縣","新竹縣", "新竹市", "苗栗縣", "臺中市","彰化縣","南投縣","雲林縣", "嘉義市", "嘉義縣", "臺南市","高雄市","屏東縣","花蓮縣","臺東縣","澎湖縣", "金門縣", "連江縣"]
    
    ///讀取公開資料
    func loadProductData(finished:(animals: [Animals]) -> ()) {
        SVProgressHUD.showWithStatus("正在加載...")
        Alamofire.request(.GET, baseURL).responseJSON { (response) in
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
    
    // MARK : - 讀取需要的資料
    func loadNeedData(keyword: String, finished:(animals: [Animals]) -> ()) {
        SVProgressHUD.showWithStatus("正在加載...")
        Alamofire.request(.GET, baseURL).responseJSON { (response) in
            guard response.result.isSuccess else {
                
                SVProgressHUD.showErrorWithStatus("加載失敗...")
                return
            }
            if let value = response.result.value {
                
                let dict = JSON(value)
                if let items = dict.arrayObject {
                    var animalArray = [Animals]()
                    for item in items {
                        
                        let oneAnimal = Animals(dict: item as! [String : AnyObject])
                        
                        //若是全部直接全放進去
                        if keyword == "全部" {
                            
                            animalArray.append(oneAnimal)
                            
                        }else { //篩選需要的資料
                            
                            for (var i = 1 ; i < self.cityArr.count ; i++) {
                                
                                if self.cityArr[i] == keyword {
                                    //判斷關鍵字
                                    if oneAnimal.area == (i+1) {
                                        
                                        animalArray.append(oneAnimal)
                                    }
                                }
                            }
                        }
                        SVProgressHUD.dismiss()
                    }
                    finished(animals: animalArray)
                }
            }
        }
    }
    
}

