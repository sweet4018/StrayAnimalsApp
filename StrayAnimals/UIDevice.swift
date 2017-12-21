//
//  UIDevice.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2017/11/5.
//  Copyright © 2017年 ChenZheng-Yang. All rights reserved.
//

import UIKit
import Foundation

extension UIDevice {
    
    public func isiPhoneX() -> Bool {
        
        if UIScreen.mainScreen().bounds.height == 812 {
            
            return true
        }
        return false
    }
}