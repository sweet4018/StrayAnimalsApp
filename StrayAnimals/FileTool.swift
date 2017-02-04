//
//  FileTool.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2017/2/4.
//  Copyright © 2017年 ChenZheng-Yang. All rights reserved.
//

import UIKit
import SVProgressHUD

class FileTool: NSObject {
    
    static let fileManager = NSFileManager.defaultManager()
    
    //計算單個文件大小
    class func fileSize(path: String) -> Double {
        if fileManager.fileExistsAtPath(path) {
            var dict = try? fileManager.attributesOfItemAtPath(path)
            if let fileSize = dict![NSFileSize] as? Int {
                return Double(fileSize) / 1024.0 / 1024.0
            }
        }
        return 0.0
    }
    /// 計算整個文件夾的大小
    class func folderSize(path: String) -> Double {
        var folderSize: Double = 0
        if fileManager.fileExistsAtPath(path) {
            let chilerFiles = fileManager.subpathsAtPath(path)
            for fileName in chilerFiles! {
                let tmpPath = path as NSString
                let fileFullPathName = tmpPath.stringByAppendingPathComponent(fileName)
                folderSize += FileTool.fileSize(fileFullPathName)
            }
            return folderSize
        }
        return 0
    }
    
    /// 徹底清除文件夾
    class func cleanFolder(path: String, complete:() -> ()) {
        SVProgressHUD.showWithStatus("正在清理內存", maskType: SVProgressHUDMaskType.Clear)
        let queue = dispatch_queue_create("cleanQueue", nil)
        
        dispatch_async(queue) { () -> Void in
            let chilerFiles = self.fileManager.subpathsAtPath(path)
            for fileName in chilerFiles! {
                let tmpPath = path as NSString
                let fileFullPathName = tmpPath.stringByAppendingPathComponent(fileName)
                if self.fileManager.fileExistsAtPath(fileFullPathName) {
                    do {
                        try self.fileManager.removeItemAtPath(fileFullPathName)
                    } catch _ {
                    }
                }
            }
            // 線程睡1秒 測試,實際用到是將下面代碼刪除即可
            NSThread.sleepForTimeInterval(1.0)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                SVProgressHUD.dismiss()
                complete()
            })
        }
    }
    
}
