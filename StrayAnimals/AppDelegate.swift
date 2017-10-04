//
//  AppDelegate.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2016/9/19.
//  Copyright © 2016年 ChenZheng-Yang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //創建window
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.makeKeyAndVisible()
        //檢測第一次啟動？
         if !NSUserDefaults.standardUserDefaults().boolForKey(firstLuanch){
            window?.rootViewController = NewfeatureCollectionViewController()
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: firstLuanch)
         }else{
            window?.rootViewController = TabBarController()
        }
        setAppAppearance()
        return true
    }
    
    
    //MARK: - 分享設置
    func setAppAppearance() {
        let itemAppearance = UITabBarItem.appearance()
        itemAppearance.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.blackColor(), NSFontAttributeName : UIFont.systemFontOfSize(12)], forState: .Selected)
        itemAppearance.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.grayColor(), NSFontAttributeName : UIFont.systemFontOfSize(12)], forState: .Normal)
        
        //設置導航列主題
        let navAppearance = UINavigationBar.appearance()
        // 設置導航titleView字體
        navAppearance.translucent = false
        navAppearance.titleTextAttributes = [NSFontAttributeName : theme.NavTitleFont, NSForegroundColorAttributeName : UIColor.blackColor()]
        navAppearance.barTintColor = UIColor.whiteColor()
        let item = UIBarButtonItem.appearance()
        item.setTitleTextAttributes([NSFontAttributeName : theme.NavItemFont, NSForegroundColorAttributeName : UIColor.blackColor()], forState: .Normal)
    }


    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}