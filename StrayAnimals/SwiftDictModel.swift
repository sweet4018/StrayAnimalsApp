//
//  SwiftDictModel.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2016/9/22.
//  Copyright © 2016年 ChenZheng-Yang. All rights reserved.
//

import Foundation

@objc public protocol DictModelProtocol {
    static func customClassMapping() -> [String: String]?
}

///  字典轉模型管理器
public class DictModelManager {
    
    private static let instance = DictModelManager()
    /// 全局统一访问入口
    public class var sharedManager: DictModelManager {
        return instance
    }
    
    ///  字典轉模型
    ///  - parameter dict: 數據字典
    ///  - parameter cls:  模型類
    ///
    ///  - returns: 模型對象
    public func objectWithDictionary(dict: NSDictionary, cls: AnyClass) -> AnyObject? {
        
        //動態獲取命名空間
        let ns = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        
        // 模型信息
        let infoDict = fullModelInfo(cls)
        
        let obj: AnyObject = (cls as! NSObject.Type).init()
        
        autoreleasepool {
            // 3. 遍歷模型字典
            for (k, v) in infoDict {
                
                if let value: AnyObject = dict[k] {
                    
                    if v.isEmpty {
                        if !(value === NSNull()) {
                            obj.setValue(value, forKey: k)
                        }
                        
                    } else {
                        let type = "\(value.classForCoder)"
                        
                        if type == "NSDictionary" {
                            
                            if let subObj: AnyObject = objectWithDictionary(value as! NSDictionary, cls: NSClassFromString(ns + "." + v)!) {
                                obj.setValue(subObj, forKey: k)
                            }
                            
                        } else if type == "NSArray" {
                            
                            if let subObj: AnyObject = objectsWithArray(value as! NSArray, cls: NSClassFromString(ns + "." + v)!) {
                                obj.setValue(subObj, forKey: k)
                            }
                        }
                    }
                }
            }
        }
        
        return obj
    }
    
    ///  創建自定義對像數組
    ///
    ///  - parameter NSArray: 字典數組
    ///  - parameter cls:     模型類
    ///
    ///  - returns:模型數組
    public func objectsWithArray(array: NSArray, cls: AnyClass) -> NSArray? {
        
        var list = [AnyObject]()
        
        autoreleasepool { () -> () in
            for value in array {
                let type = "\(value.classForCoder)"
                
                if type == "NSDictionary" {
                    if let subObj: AnyObject = objectWithDictionary(value as! NSDictionary, cls: cls) {
                        list.append(subObj)
                    }
                } else if type == "NSArray" {
                    if let subObj: AnyObject = objectsWithArray(value as! NSArray, cls: cls) {
                        list.append(subObj)
                    }
                }
            }
        }
        
        if list.count > 0 {
            return list
        } else {
            return nil
        }
    }
    
    ///  模型轉字典
    ///
    ///  - parameter obj: 模型對象
    ///
    ///  - returns: 字典信息
    public func objectDictionary(obj: AnyObject) -> [String: AnyObject]? {
        // 1. 取出對像模型字典
        let infoDict = fullModelInfo(obj.classForCoder)
        
        var result = [String: AnyObject]()
        // 2. 遍歷字典
        for (k, v) in infoDict {
            var value: AnyObject? = obj.valueForKey(k)
            if value == nil {
                value = NSNull()
            }
            
            if v.isEmpty || value === NSNull() {
                result[k] = value
            } else {
                let type = "\(value!.classForCoder)"
                
                var subValue: AnyObject?
                if type == "NSArray" {
                    subValue = objectArray(value! as! [AnyObject])
                } else {
                    subValue = objectDictionary(value!)
                }
                if subValue == nil {
                    subValue = NSNull()
                }
                result[k] = subValue
            }
        }
        
        if result.count > 0 {
            return result
        } else {
            return nil
        }
    }
    
    /// 模型數組轉字典數組
    /// - parameter array: 模型數組
    /// - returns: 字典數組
    public func objectArray(array: [AnyObject]) -> [AnyObject]? {
        
        var result = [AnyObject]()
        
        for value in array {
            let type = "\(value.classForCoder)"
            
            var subValue: AnyObject?
            if type == "NSArray" {
                subValue = objectArray(value as! [AnyObject])
            } else {
                subValue = objectDictionary(value)
            }
            if subValue != nil {
                result.append(subValue!)
            }
        }
        
        if result.count > 0 {
            return result
        } else {
            return nil
        }
    }
    
    // MARK: - 私有函數
    /// 加載完整類信息
    ///
    /// - parameter cls: 模型類
    ///- returns: 模型類完整信息
    func fullModelInfo(cls: AnyClass) -> [String: String] {
        
        // 檢測緩衝池
        if let cache = modelCache["\(cls)"] {
            return cache
        }
        
        var currentCls: AnyClass = cls
        
        var infoDict = [String: String]()
        while let parent: AnyClass = currentCls.superclass() {
            infoDict.merge(modelInfo(currentCls))
            currentCls = parent
        }
        
      // 寫入緩衝池
        modelCache["\(cls)"] = infoDict
        
        return infoDict
    }
    
    /// 加載類信息
    ///
    /// - parameter cls: 模型類
    ///
    /// - returns: 模型類信息
    func modelInfo(cls: AnyClass) -> [String: String] {
       // 檢測緩衝池
        if let cache = modelCache["\(cls)"] {
            return cache
        }
        
        // 拷貝屬性列表
        var count: UInt32 = 0
        let properties = class_copyPropertyList(cls, &count)
        
        // 檢查類是否實現了協議
        var mappingDict: [String: String]?
        if cls.respondsToSelector("customClassMapping") {
            mappingDict = cls.customClassMapping()
        }
        
        var infoDict = [String: String]()
        for i in 0..<count {
            let property = properties[Int(i)]
            
            //屬性名稱
            let cname = property_getName(property)
            let name = String.fromCString(cname)!
            
            let type = mappingDict?[name] ?? ""
            
            infoDict[name] = type
        }
        
        free(properties)
        
        // 寫入緩衝池
        modelCache["\(cls)"] = infoDict
        
        return infoDict
    }
    
    /// 模型緩衝，[類名: 模型信息字典]
    var modelCache = [String: [String: String]]()
}

extension Dictionary {
    ///  將字典合併到當前字典
    mutating func merge<K, V>(dict: [K: V]) {
        for (k, v) in dict {
            self.updateValue(v as! Value, forKey: k as! Key)
        }
    }
}
