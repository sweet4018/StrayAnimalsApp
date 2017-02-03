//
//  MeViewController.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2016/9/21.
//  Copyright © 2016年 ChenZheng-Yang. All rights reserved.
//

import UIKit

enum MeCellType:Int {
    ///留言回饋
    case Feedback = 0
    ///給我們評價
    case GiveEvaluation = 1
    ///點讚
    case ForLike = 2
    ///應用推薦
    case RecommendApp = 3
    ///推薦給朋友
    case Recommendtofriends = 4
    ///關於我們
    case About = 5
}

class MeViewController: BaseViewController {
    
    private var tableView:UITableView!
    
    private lazy var meIcon : NSMutableArray = NSMutableArray(array: ["feedback","usercenter","score","recomment","recommendfriend","about"])

    private lazy var meTitle : NSMutableArray = NSMutableArray(array: ["留言回饋","給我們評價","到GitHub給個讚","其他應用推薦","推薦給朋友","關於我們"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ///初始化導航列
        setNav()
        
        ///設置tableView
        setTableView()
    }

    private func setNav(){
        navigationItem.title = "我的"
    }
    private func setTableView(){
        self.automaticallyAdjustsScrollViewInsets = false
        tableView = UITableView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight), style: UITableViewStyle.Grouped)
        tableView.backgroundColor = ZYGrayColor()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 45
        tableView.sectionFooterHeight = 0.1
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        view.addSubview(tableView)
    }
  }

extension MeViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return meTitle.count
        }else {
            return 1
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier : String = "cell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: identifier)
            cell!.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            cell!.selectionStyle = .None
        }
        if indexPath.section == 0 {
            cell!.imageView!.image = UIImage(named: meIcon[indexPath.row] as! String)
            cell!.textLabel?.text = meTitle[indexPath.row] as? String
        }else {
            cell!.imageView!.image = UIImage(named: "remove")
            cell!.textLabel?.text = "清理內存"
        }
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            
            if indexPath.row == MeCellType.Feedback.hashValue {
                
            }
        }
    }
    
}
