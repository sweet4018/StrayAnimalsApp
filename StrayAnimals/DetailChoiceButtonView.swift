//
//  DetailChoiceButtonView.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2016/9/27.
//  Copyright © 2016年 ChenZheng-Yang. All rights reserved.
//

import UIKit

protocol DetailChoiceButtonViewDelegate: NSObjectProtocol {
    /// 介绍按鈕點擊
    func choiceIntroduceButtonClick()
    /// 收容所詳細資料點擊
    func choiceshelterButtonClick()
}


class DetailChoiceButtonView: UIView {

    weak var delegate:DetailChoiceButtonViewDelegate?
    
    @IBOutlet weak var lineView: UIView!
   
    @IBOutlet weak var shelterInfo: UIButton!


    
    @IBOutlet weak var leadingConstraint : NSLayoutConstraint!
    
    @IBAction func introduceAnimal(sender: UIButton) {
        UIView.animateWithDuration(kAnimationDuration){
            self.lineView.xx = 0
        }
        delegate?.choiceIntroduceButtonClick()
    }
    

    @IBAction func shelterButtonClick(sender: UIButton) {
        UIView.animateWithDuration(kAnimationDuration){
            self.lineView.xx = ScreenWidth * 0.5
        }
        delegate?.choiceshelterButtonClick()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    class func choiceButtonView() -> DetailChoiceButtonView{
        return NSBundle.mainBundle().loadNibNamed(String(self), owner: nil, options: nil).last as! DetailChoiceButtonView
    }

}
