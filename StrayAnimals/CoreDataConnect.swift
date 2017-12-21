//
//  CoreDataConnect.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2017/10/1.
//  Copyright © 2017年 ChenZheng-Yang. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataConnect {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    typealias MyType = Animal
    
    // MARK: - 新增資料
    func insert(entityName: String ,attributeInfo: [String:String],imageData: NSData?) -> Bool {
        
        //先刪除此資料，避免資料重複
        let key: String = attributeInfo["id"]!
        let predicate = NSPredicate(format: "name == %@",key)
        let deleteResult = delete(coreDataEntityAnimal, predicate: predicate)
        print("刪除結果:\(deleteResult)")
        
        let insetData = NSEntityDescription.insertNewObjectForEntityForName("Animal", inManagedObjectContext: self.managedObjectContext) as! MyType
        
        for (key,value) in attributeInfo {
            
            let t = insetData.entity.attributesByName[key]?.attributeType
            
            if t == .Integer16AttributeType  || t == .Integer32AttributeType || t == .Integer64AttributeType {
                
                insetData.setValue(Int(value),forKey: key)
                
            } else if t == .DoubleAttributeType || t == .FloatAttributeType {
                
                insetData.setValue(Double(value),forKey: key)
                
            } else if t == .BooleanAttributeType {
                
                insetData.setValue((value == "true" ? true : false),forKey: key)
            }
            else {
                
                insetData.setValue(value, forKey: key)
            }
        }
        
        //圖片處理
        if let animalImage = imageData {
            
            insetData.image = animalImage
        }
        
        do {
            
            try managedObjectContext.save()
            
            return true
            
        }catch {
            
            fatalError("\(error)")        
        }

        return false
    }
    
    // MARK: - 讀取資料
    /*ex
     let key = "hello~"
     let predicate = NSPredicate(format: "name == %@",key)
     
     let selectResult = coreDataTool.fetch(coreDataEntityAnimal, predicate: nil, sort: [["name":true]], limit: nil)
     if let results = selectResult {
        for result in results {     
            print("name:\(result.name)")
        }
     }
     */
    func fetch(myEntityName: String, predicate: NSPredicate?, sort:[[String:Bool]]?, limit: Int?) -> [MyType]? {
        
        let request = NSFetchRequest(entityName: myEntityName)
        
        if let myPredicate = predicate {
            
            request.predicate = myPredicate
        }
     
        if let mySort = sort {
            
            var sortArr :[NSSortDescriptor] = []
            for sortCond in mySort {
                for (k, v) in sortCond {
                    sortArr.append(NSSortDescriptor(key: k, ascending: v))
                }
            }
            request.sortDescriptors = sortArr
        }
        
        if let limitNumber = limit {
            
            request.fetchLimit = limitNumber
        }
        
        do {
            
            let results = try self.managedObjectContext.executeFetchRequest(request) as! [MyType]
            
            return results
            
        } catch {
            
            fatalError("\(error)")
        }
        
        return nil
    }
    
    // MARK: - 刪除資料
    /* ex
     let key = "hello~"
     let predicate = NSPredicate(format: "name == %@",key)
     let deleteResult = coreDataTool.delete(coreDataEntityAnimal, predicate: predicate)
     print("刪除結果:\(deleteResult)")
     */
    func delete(myEntityName: String, predicate: NSPredicate?) -> Bool {
        
        if let results = self.fetch(myEntityName, predicate: predicate, sort: nil, limit: nil) {
            
            for result in results {
                self.managedObjectContext.deleteObject(result)
            }
            
            do {
                try self.managedObjectContext.save()
                
                return true
                
            } catch {
                fatalError("\(error)")
            }
        }
        return false
    }
}