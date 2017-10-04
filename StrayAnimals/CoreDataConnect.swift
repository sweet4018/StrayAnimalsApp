//
//  CoreDataConnect.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2017/10/1.
//  Copyright © 2017年 ChenZheng-Yang. All rights reserved.
//

import Foundation
import CoreData

class CoreDataConnect {
    
    var moc: NSManagedObjectContext!
    typealias MyType = Animal
    
    init(moc:NSManagedObjectContext) {
        self.moc = moc
    }
    
    func insert(entityName: String ,attributeInfo: [String:String]) -> Bool {
        
        let insetData = NSEntityDescription.insertNewObjectForEntityForName(entityName, inManagedObjectContext: self.moc) as! MyType
        
        
        for (key,value) in attributeInfo {
            
            let t = insetData.entity.attributesByName[key]?.attributeType
            
            if t == .Integer16AttributeType  || t == .Integer32AttributeType || t == .Integer64AttributeType {
                
                insetData.setValue(Int(value),forKey: key)
                
            } else if t == .DoubleAttributeType || t == .FloatAttributeType {
                
                insetData.setValue(Double(value),forKey: key)
                
            }else if t == .BooleanAttributeType {
                
                insetData.setValue((value == "true" ? true : false),forKey: key)
                
            } else {
                
                insetData.setValue(value, forKey: key)
            }
        }
        
        do {
            
            try moc.save()
            
            return true
            
        }catch {
            
            fatalError("\(error)")
        }
        return false
    }
}