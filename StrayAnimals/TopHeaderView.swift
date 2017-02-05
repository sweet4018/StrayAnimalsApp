//
//  TopHeaderView.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2017/2/5.
//  Copyright © 2017年 ChenZheng-Yang. All rights reserved.
//

import UIKit

protocol TopHeaderViewDelegate: NSObjectProtocol {
    func topViewDidClickedMoreButton(button: UIButton)
}

class TopHeaderView: UIView {

    weak var delegate: TopHeaderViewDelegate?
    
    ///查看全部
    @IBAction func viewAllButton(sender: UIButton) {
        delegate?.topViewDidClickedMoreButton(sender)
    }


}
