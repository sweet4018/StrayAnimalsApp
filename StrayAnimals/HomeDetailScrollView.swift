//
//  DetailScrollView.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2016/9/26.
//  Copyright © 2016年 ChenZheng-Yang. All rights reserved.
//

import UIKit

class HomeDetailScrollView: UIScrollView {

    var animal : Animals? {
        didSet {
            topScrollView.animal = animal
            buttonScrollView.animal = animal
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    func setupUI() {
        addSubview(topScrollView)
        addSubview(buttonScrollView)
        topScrollView.snp_makeConstraints { (make) in
            make.left.equalTo(self)
            make.top.equalTo(self)
            make.size.equalTo(CGSizeMake(ScreenWidth, ScreenWidth))
        }
        buttonScrollView.snp_makeConstraints { (make) in
            make.left.equalTo(self)
            make.top.equalTo(topScrollView.snp_bottom).offset(kMargin)
            make.size.equalTo(CGSizeMake(ScreenWidth, ScreenHeight ))
        }
    }
    
    ///頂部滾動視圖
    private lazy var topScrollView : HomeDetailTopView = {
       let topScrollView = HomeDetailTopView()
       topScrollView.backgroundColor = UIColor.whiteColor()
       return topScrollView
    }()
    
    ///底部滾動視圖
    private lazy var buttonScrollView: HomeDetailButtonView = {
        let buttonScrollView = HomeDetailButtonView()
        buttonScrollView.backgroundColor = UIColor.whiteColor()
        return buttonScrollView
    }()

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
