//
//  HomeDetailBottonView.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2016/9/27.
//  Copyright © 2016年 ChenZheng-Yang. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

let detailCellID = "detailCellID"

class HomeDetailButtonView: UIView {
    
    private lazy var detailContentView: ShopDetailContentView = ShopDetailContentView.shopDetailContentViewFromXib()
    
    var animalDetail : Animals?
    
    var animal : Animals? {
        didSet {
        weak var weakSelf = self
        //動物
        animalDetail = animal
        weakSelf!.animalView.reloadData()
        //收容所
        detailContentView.detailModel = animal
        shelterView.addSubview(detailContentView)
        shelterView.contentSize = CGSize(width: ScreenWidth, height: detailContentView.height - 0)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    func setupUI() {
        // 添加頂部選擇按鈕view（動物、收容所介绍）
        addSubview(choiceButtonView)
        addSubview(shelterView)
        addSubview(animalView)
        
        choiceButtonView.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(ScreenWidth, 44))
            make.top.equalTo(self)
        }
        
        animalView.snp_makeConstraints{ (make) in
            make.top.equalTo(choiceButtonView.snp_bottom)
            make.left.right.bottom.equalTo(self)
        }
        
        shelterView.snp_makeConstraints{ (make) in
            make.top.equalTo(choiceButtonView.snp_bottom)
            make.left.right.bottom.equalTo(self)
        }
        
    }
    
    private lazy var shelterView: UIScrollView = {
        let detailSV = UIScrollView(frame: MainBounds)
        detailSV.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        detailSV.showsHorizontalScrollIndicator = false
        detailSV.backgroundColor = ZYGrayColor()
        detailSV.alwaysBounceVertical = true
        detailSV.hidden = true
        detailSV.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        return detailSV
    }()
    
    private lazy var animalView : UITableView = {
        let animalView = UITableView()
        let nib = UINib(nibName: String(AnimalViewCell), bundle: nil)
        animalView.registerNib(nib, forCellReuseIdentifier: detailCellID)
        animalView.dataSource = self
        animalView.rowHeight = 58
        animalView.separatorStyle = .None
        return animalView
    }()
    
    private lazy var choiceButtonView: DetailChoiceButtonView = {
        let choiceButtonView = DetailChoiceButtonView.choiceButtonView()
        choiceButtonView.delegate = self
        return choiceButtonView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeDetailButtonView :DetailChoiceButtonViewDelegate,UITableViewDataSource {
    
    //MARK: -HomeChoiceButtonViewDelegate
    func choiceshelterButtonClick() {
        shelterView.hidden = false
        animalView.hidden = true
    }
    
    func choiceIntroduceButtonClick() {
        shelterView.hidden = true
        animalView.hidden = false
    }
    
    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(detailCellID) as! AnimalViewCell
        
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "編號"
            cell.detailLabel?.text = String(animalDetail!.ID!)
        case 1:
            cell.titleLabel.text = "子編號"
            cell.detailLabel?.text = String(animalDetail!.subID!)
        case 2:
            cell.titleLabel.text = "體型"
            let type = String(animalDetail!.type!)
            switch type {
                case "MINI":
                cell.detailLabel.text = "迷你"
                case "SMALL":
                cell.detailLabel.text = "小型"
                case "MEDIUM":
                cell.detailLabel.text = "中型"
                case "BIG":
                cell.detailLabel.text = "大型"
            default:
                cell.detailLabel.text = "未提供"
            }
            
        case 3:
            cell.titleLabel.text = "性別"
            let sex = String(animalDetail?.sex!)
            switch sex {
            case "M":
                cell.detailLabel.text = "男生"
            case "F":
                cell.detailLabel.text = "女生"
            default:
                cell.detailLabel.text = "未提供"
            }
            
        case 4:
            cell.titleLabel.text = "毛色"
            cell.detailLabel!.text = String(animalDetail!.color!)
        case 5:
            cell.titleLabel.text = "年紀"
            let age = String(animalDetail?.age!)
            if age == "CHILD" {
                cell.detailLabel?.text = "幼年"
            }else{
                cell.detailLabel?.text = "成年"
            }
        case 6:
            cell.titleLabel.text = "尋獲地"
            let foundPlace = String(animalDetail!.foundPlace!)
            if foundPlace == "" {
                cell.detailLabel!.text = "未輸入"
            }else{
                cell.detailLabel!.text = String(animalDetail!.foundPlace!)
            }
            
        case 7:
            cell.titleLabel.text = "是否絕育"
            let sterilization = String(animalDetail?.sterilization!)
            switch sterilization {
            case "T" :
                cell.detailLabel?.text = "已絕育"
            case "F" :
                cell.detailLabel?.text = "未絕育"
            default:
                cell.detailLabel?.text = "未輸入"
            }
        case 8:
            cell.titleLabel.text = "施打狂犬疫苗"
            let bacterin = String(animalDetail?.bacterin!)
            switch bacterin {
            case "T" :
                cell.detailLabel?.text = "已施打"
            case "F" :
                cell.detailLabel?.text = "未施打"
            default:
                cell.detailLabel?.text = "未輸入"
            }
        default:
            cell.titleLabel.text = "備註"
            let remark = String(animalDetail!.remark!)
            if remark == "" {
                cell.detailLabel!.text = "無"
            }else{
                cell.detailLabel!.text = String(animalDetail!.remark!)
            }
        }
 
        return cell
    }


}
