//
//  MainTableView.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2016/9/22.
//  Copyright © 2016年 ChenZheng-Yang. All rights reserved.
//

import UIKit

class MainTableView: UITableView {

    init(frame: CGRect, style: UITableViewStyle, dataSource: UITableViewDataSource?, delegate: UITableViewDelegate?) {
        
        super.init(frame: frame, style: style)
        self.delegate = delegate
        self.dataSource = dataSource
        separatorStyle = .None
        backgroundColor = theme.BackgroundColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
