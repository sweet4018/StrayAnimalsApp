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
    
    let baseURL = "http://data.coa.gov.tw/Service/OpenData/AnimalOpenData.aspx"
    
    let baseURLforSkip = "http://data.coa.gov.tw/Service/OpenData/AnimalOpenData.aspx?$top=10&$skip="
    
    var url: String = ""
    
    ///讀取公開資料
    func loadProductData(skipCount: String, city: String,finished:(animals: [Animals]) -> ()) {
        
        SVProgressHUD.showWithStatus("正在加載...")
        
        if city == "全部" {
            
            url = baseURLforSkip + skipCount
            
        }else {
        
            var searchCity = ""
            var i = 0
            for cityName in cityArr {
                i += 1
                if cityName == city {
                    searchCity = String(i)
                }
            }
            
            let urlToSkipAndCity = "http://data.coa.gov.tw/Service/OpenData/AnimalOpenData.aspx?$top=10&$skip=\(skipCount)&$filter=animal_area_pkid+like+\(searchCity)"

            url = urlToSkipAndCity
        }
        
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
    
    ///在分類頁面使用 多重條件
    func loadAnimalsData(skipCount: Int, dict: Dictionary<String, String>, finished:(animals: [Animals]) ->()) {
        
        var result:String = ""
        
        SVProgressHUD.showWithStatus("正在加載...")
        
        var i:Int = 0
        var isAll: Bool = true
        for (key , values) in dict {
            
            if values != "全部" {
                isAll = false
                
                if i == 0 {
                    result = "&$filter=" + key + "+like+" + values
                    
                }else {
                    result += "+and+" + key + "+like+" + values
                }

                i += 1
            }
        }
        
        url = baseURLforSkip + String(skipCount)
        
        if !isAll {
            url += result
        }
        
        let encodeWord = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        
        Alamofire.request(.GET, encodeWord!).responseJSON { (response) in
            guard response.result.isSuccess else {
                SVProgressHUD.showErrorWithStatus("加載失敗...")
                return
            }
            SVProgressHUD.dismiss()
            if let value = response.result.value {
                let dict = JSON(value)
                
                if let items = dict.arrayObject {
                    var animalArray = [Animals]()
                    for item in items {
                        let oneAnimal = Animals(dict: item as! [String: AnyObject])
                        animalArray.append(oneAnimal)                        
                    }
                    finished(animals: animalArray)
                }
            }
        }
    }
    
}

