//
//  HomeDetailToolBar.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2016/9/26.
//  Copyright © 2016年 ChenZheng-Yang. All rights reserved.
//

import UIKit

protocol HomeDetailToolBarDelegate: NSObjectProtocol {
    func toolBarDidClickedTMALLButton()
}


class HomeDetailToolBar: UIView {
    
    weak var delegate : HomeDetailToolBarDelegate?
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var takeHomeButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        favoriteButton.layer.borderColor = ZYBlackColor().CGColor
        favoriteButton.layer.borderWidth = klineWidth
        takeHomeButton.layer.borderColor = ZYBlackColor().CGColor
        takeHomeButton.layer.borderWidth = klineWidth
        favoriteButton.setImage(UIImage(named: "collect_1"), forState: .Normal)
        favoriteButton.setImage(UIImage(named: "collect_2"), forState: .Selected)
    }
    
    @IBAction func likeButtonClick(sender: UIButton) {
        sender.selected = !sender.selected
    }
    

    @IBAction func goTMALLButtonClick() {
        delegate!.toolBarDidClickedTMALLButton()
    }


}
