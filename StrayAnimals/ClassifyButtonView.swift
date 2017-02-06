//
//  ClassifyButtonView.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2017/2/5.
//  Copyright © 2017年 ChenZheng-Yang. All rights reserved.
//

import UIKit
import Kingfisher

protocol CategoryBottomViewDelegate: NSObjectProtocol {
    func bottomViewButtonDidClicked(button: UIButton)
}

class ClassifyButtonView: UIView {

     weak var delegate: CategoryBottomViewDelegate?
    
    var outGroups = [AnyObject]()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        /// 分类界面 风格,品类
        NetworkTool.shareNetworkTool.loadCategoryGroup { [weak self] (outGroups) in
            self!.outGroups = outGroups
            self!.setupUI()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let topGroups = outGroups[0] as! NSArray
        let bottomGroups = outGroups[1] as! NSArray
        
        // 风格
        let topView = UIView()
        topView.ZYWidth = ScreenWidth
        topView.backgroundColor = UIColor.whiteColor()
        addSubview(topView)
        let styleLabel = setupLabel("风格")
        topView.addSubview(styleLabel)
        
        for index in 0..<topGroups.count {
            let group = topGroups[index] as! ZYGroup
            let button = setupButton(index, group: group)
            topView.addSubview(button)
            if index == topGroups.count - 1 {
                topView.ZYHeight = CGRectGetMaxY(button.frame) + kMargin
            }
        }
        
        // 品类
        let bottomView = UIView()
        bottomView.ZYWidth = ScreenWidth
        bottomView.ZYy = CGRectGetMaxY(topView.frame) + kMargin
        bottomView.backgroundColor = UIColor.whiteColor()
        addSubview(bottomView)
        let categoryLabel = setupLabel("品类")
        bottomView.addSubview(categoryLabel)
        
        for index in 0..<bottomGroups.count {
            let group = bottomGroups[index] as! ZYGroup
            let button = setupButton(index, group: group)
            bottomView.addSubview(button)
            if index == bottomGroups.count - 1 {
                bottomView.ZYHeight = CGRectGetMaxY(button.frame) + kMargin
            }
        }
    }
    
    private func setupButton(index: Int, group: ZYGroup) -> VerticalButton{
        let buttonW: CGFloat = ScreenWidth / 4
        let buttonH: CGFloat = buttonW
        let styleLabelH: CGFloat = 40
        
        let button = VerticalButton()
        button.ZYWidth = buttonW
        button.ZYHeight = buttonH
        button.ZYx = buttonW * CGFloat(index % 4)
        button.ZYy = buttonH * CGFloat(index / 4) + styleLabelH
        if index > 3 {
            button.ZYy = buttonH * CGFloat(index / 4) + styleLabelH + kMargin
        }
        button.tag = group.id!
        button.addTarget(self, action: #selector(groupButonClick(_:)), forControlEvents: .TouchUpInside)
        button.titleLabel?.font = UIFont.systemFontOfSize(15)
        button.setTitleColor(ZYColor(0, g: 0, b: 0, a: 0.6), forState: .Normal)
        button.kf_setImageWithURL(NSURL(string: group.icon_url!)!, forState: .Normal)
        button.setTitle(group.name, forState: .Normal)
        return button
    }
    
    func groupButonClick(button: UIButton) {
        delegate?.bottomViewButtonDidClicked(button)
    }
    
    private func setupLabel(title: String) -> UILabel {
        let styleLabel = UILabel(frame: CGRectMake(10, 0, ScreenWidth - 10, 40))
        styleLabel.text = title
        styleLabel.textColor = ZYColor(0, g: 0, b: 0, a: 0.6)
        styleLabel.font = UIFont.systemFontOfSize(16)
        return styleLabel
    }

}
