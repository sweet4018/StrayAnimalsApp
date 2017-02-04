//
//  AboutViewController.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2017/2/4.
//  Copyright © 2017年 ChenZheng-Yang. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    init() {
        super.init(nibName: "AboutViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(nibName: "AboutViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "關於我們"
    }

    
}
