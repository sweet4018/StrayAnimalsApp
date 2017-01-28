//
//  UIColor.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2016/9/21.
//  Copyright © 2016年 ChenZheng-Yang. All rights reserved.
//

import Foundation
import UIKit

///擴展UIColor
extension UIColor {
    class func colorWith(red:Int , green:Int , blue:Int , alpha:CGFloat) -> UIColor {
        let color = UIColor (red: CGFloat(red)/255.0, green:CGFloat(green)/255.0 , blue:CGFloat(blue)/255.0 ,alpha: alpha)
        return color
    }
}


