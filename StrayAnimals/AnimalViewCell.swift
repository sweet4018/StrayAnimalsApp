//
//  AnimalViewCell.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2016/9/30.
//  Copyright © 2016年 ChenZheng-Yang. All rights reserved.
//

import UIKit

class AnimalViewCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
   
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
