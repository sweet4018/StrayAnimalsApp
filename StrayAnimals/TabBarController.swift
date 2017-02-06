//
//  TabBarController.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2016/9/20.
//  Copyright © 2016年 ChenZheng-Yang. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAllChildViewController()
        self.setValue(MainTabBar(), forKey: "tabBar")
    }
    
    private func setUpAllChildViewController(){
        //首頁
        tabBarAddChildViewController(vc: HomeViewController(), title: "首頁", imageName: "recommendation_1", selectedImageName: "recommendation_2")
        //最愛
        tabBarAddChildViewController(vc: FavoriteViewController(), title: "最愛", imageName: "broadwood_1", selectedImageName: "broadwood_2")
        //分類
        tabBarAddChildViewController(vc: ClassifyViewController(), title: "分類", imageName: "classification_1", selectedImageName: "classification_2")
        //我的
        tabBarAddChildViewController(vc: MeViewController(), title: "我的", imageName: "my_1", selectedImageName: "my_2")
    }

    private func tabBarAddChildViewController(vc vc:UIViewController, title:String, imageName:String, selectedImageName:String){
        vc.tabBarItem = UITabBarItem(title: title, image: UIImage(named: imageName), selectedImage: UIImage(named: selectedImageName))
        vc.view.backgroundColor = theme.BackgroundColor
        let nav = NavigationController(rootViewController: vc)
        addChildViewController(nav)
    }
    
class MainTabBar : UITabBar {
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.translucent = true
            self.backgroundImage = UIImage(named: "tabbar")
        }
        required init?(coder aDecoder:NSCoder){
            super.init(coder: aDecoder)
        }
    }

}
