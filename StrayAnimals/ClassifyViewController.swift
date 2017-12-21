//
//  ClassifyViewController.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2016/9/21.
//  Copyright © 2016年 ChenZheng-Yang. All rights reserved.
//

import UIKit

class ClassifyViewController: BaseViewController, ClassifyMainViewDelegate {

    
    // MARK:- 屬性
    let classifyDetailVC = ClassifyDetailViewController()
    
    // MARK:- ViewController生命週期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNav()
        setUI()
        
    }

    
    // MARK:- 設置UI
    // MARK: 設置導航列
    private func setNav() {
        
        navigationItem.title = "分類"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "開始搜尋", titleClocr: ZYBlackColor(), targer: self, action: #selector(ClassifyViewController.startSearch))
        
    }
    
    func startSearch() {
        
        print("點擊開始搜尋")
        navigationController?.pushViewController(classifyDetailVC, animated: true)
    }
    
    private func setUI() {
        
        view.addSubview(scrollView)
        
        let mainView = ClassifyMainView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight))
        mainView.delegate = self
        scrollView.addSubview(mainView)
        scrollView.contentSize = CGSizeMake(ScreenWidth, 150*5)
    }
   
    //懶加載滾動視圖
    private lazy var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.scrollEnabled = true
        scrollView.backgroundColor = ZYColor(240, g: 240, b: 240, a: 1)
        scrollView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight)
    
        return scrollView
    }()
    
    // MARK:- 按鈕點擊
    func buttonDidClicked(button: UIButton) {
        
        print("點擊第幾個？\(button.tag)")
        
        let classifyDetailVC = ClassifyDetailViewController()
        classifyDetailVC.title = button.titleLabel?.text!
        navigationController?.pushViewController(classifyDetailVC, animated: true)
    }
    
    func pickerViewDataUpdate(pickerData: Dictionary<String, String>) {
        
        classifyDetailVC.searchKeyDataDic = pickerData
    }
    
    //搜尋
    func searchAction() {
        
    }
    
    
  
    
}