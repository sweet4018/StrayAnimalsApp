//
//  Animal+CoreDataProperties.swift
//  
//
//  Created by ChenZheng-Yang on 2017/10/1.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Animal {

    @NSManaged var image: NSData?
    @NSManaged var id: String?
    @NSManaged var subID: String?
    @NSManaged var name: String?
    @NSManaged var address: String?
    @NSManaged var tel: String?
    @NSManaged var type: String?
    @NSManaged var sex: String?
    @NSManaged var color: String?
    @NSManaged var age: String?
    @NSManaged var foundPlace: String?
    @NSManaged var sterilization: String?
    @NSManaged var bacterin: String?
    @NSManaged var remark: String?
    @NSManaged var update: String?
    @NSManaged var createTime: String?
    @NSManaged var area: NSNumber?

}
