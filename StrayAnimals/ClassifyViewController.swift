//
//  ClassifyViewController.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2016/9/21.
//  Copyright © 2016年 ChenZheng-Yang. All rights reserved.
//

import UIKit

class ClassifyViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "search_1"), style: .Plain, target: self,action: #selector(classifyRightBtn))
        setupScrollView()
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        // 顶部控制器
        let headerViewController = ClassifyHeaderViewController()
        addChildViewController(headerViewController)
        
        let topBGView = UIView(frame: CGRectMake(0, 0, ScreenWidth, 135))
        scrollView.addSubview(topBGView)
        
        let headerVC = childViewControllers[0]
        topBGView.addSubview(headerVC.view)
//        
//        let bottomBGView = ClassifyButtonView(frame: CGRectMake(0, CGRectGetMaxY(topBGView.frame) + 10, ScreenWidth, ScreenHeight - 160))
//        bottomBGView.backgroundColor = ZYGrayColor()
//        bottomBGView.delegate = self
//        scrollView.addSubview(bottomBGView)
//        scrollView.contentSize = CGSizeMake(ScreenWidth, CGRectGetMaxY(bottomBGView.frame))
    }
    
    /// 懶加載創建 scrollView
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.scrollEnabled = true
        scrollView.backgroundColor = ZYGrayColor()
        scrollView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight)
        return scrollView
    }()

//    func bottomViewButtonDidClicked(button: UIButton) {
//        let collectionDetailVC = YMCollectionDetailController()
//        collectionDetailVC.title = button.titleLabel?.text!
//        collectionDetailVC.id = button.tag
//        collectionDetailVC.type = "风格品类"
//        navigationController?.pushViewController(collectionDetailVC, animated: true)
//    }
//
    
    
    
    
    func classifyRightBtn(){
        
    }
    
}