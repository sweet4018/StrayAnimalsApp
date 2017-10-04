//
//  SearchResult.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2016/9/21.
//  Copyright © 2016年 ChenZheng-Yang. All rights reserved.
//

import UIKit

class SearchResult: NSObject {

    var image : String?
    var ID : String?
    var subID : String?
    var name : String?
    var address : String?
    var tel : String?
    var type : String?
    var sex : String?
    var color : String?
    var age : String?
    var foundPlace : String?
    var sterilization : String?
    var bacterin : String?
    var remark : String?
    var update : String?
    var area: String?
    
    init(dict:[String:AnyObject]){
        super.init()
        image = dict["album_file"] as? String
        ID = dict["animal_id"] as? String
        subID = dict["animal_subid"] as? String
        name = dict["shelter_name"] as? String
        address = dict["shelter_address"] as? String
        tel = dict ["shelter_tel"] as? String
        type = dict ["animal_bodytype"] as? String
        sex = dict ["animal_sex"] as? String
        color = dict ["animal_colour"] as? String
        age = dict ["animal_age"] as? String
        foundPlace = dict ["animal_foundplace"] as? String
        sterilization = dict ["animal_sterilization"] as? String
        bacterin = dict ["animal_bacterin"] as? String
        remark = dict ["animal_remark"] as? String
        update = dict ["animal_update"] as? String
        area = dict["animal_area_pkid"] as? String
    }

    
}
