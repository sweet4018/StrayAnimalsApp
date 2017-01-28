//
//  ThemeCell.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2016/9/22.
//  Copyright © 2016年 ChenZheng-Yang. All rights reserved.
//

import UIKit

class ThemeCell: UITableViewCell {
    
    var model: ThemeModel? {
        didSet {
            titleLabel.text = model!.title
            subTitleLabel.text = model!.keywords
            backImageView.wxn_setImageWithURL(NSURL(string: model!.img!)!, placeholderImage: UIImage(named: "quesheng")!)
        }
    }
    
    @IBOutlet var backImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        self.titleLabel.shadowOffset = CGSizeMake(-1, 1)
        self.titleLabel.shadowColor = UIColor.colorWith(20, green: 20, blue: 20, alpha: 0.1)
        self.subTitleLabel.shadowOffset = CGSizeMake(-1, 1)
        self.subTitleLabel.shadowColor = UIColor.colorWith(20, green: 20, blue: 20, alpha: 0.1)
    }
    
    class func themeCellWithTableView(tableView: UITableView) -> ThemeCell {
        let identifier = "themeCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? ThemeCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("ThemeCell", owner: nil, options: nil).last as? ThemeCell
            
        }
        
        return cell!
    }

    
}
