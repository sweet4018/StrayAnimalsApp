//
//  BaseClassify.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2017/10/15.
//  Copyright © 2017年 ChenZheng-Yang. All rights reserved.
//

import Foundation

class BaseClassify {

    ///按鈕名稱
    var title: String = ""
    ///按鈕圖片
    var imageName: String = ""
    ///ID
    var ID: String = ""
    
    init(title: String, imageName: String,ID: String) {
        self.title = title
        self.imageName = imageName
        self.ID = ID
    }
    

}
