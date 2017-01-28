//
//  HomeDetailViewController.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2016/9/21.
//  Copyright © 2016年 ChenZheng-Yang. All rights reserved.
//

import UIKit
import Kingfisher

class HomeDetailViewController: BaseViewController , HomeDetailToolBarDelegate{
    
    var animals : Animals?
    
    var result : SearchResult?
    
    var type = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    ///設置底部和導航列
    func setupUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "share_1", highlImageName: "share_2", targer: self, action: #selector(shareBBItemClick))
        
        view.clipsToBounds = true
        //添加滾動視圖
        view.addSubview(scrollView)
        //添加底下欄
        view.addSubview(toolBarView)
        scrollView.animal = animals
     
        scrollView.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(view)
            make.bottom.equalTo(toolBarView.snp_top)
        }
        
        toolBarView.snp_makeConstraints { (make) in
            make.left.bottom.right.equalTo(view)
            make.height.equalTo(45)
        }
        scrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight + kMargin + 520)
    }
    ///分享按鈕點擊
    func shareBBItemClick(){
        let text = "動物編號：" + self.animals!.ID! + "\n\n收容所名稱：" + self.animals!.name! + "\n\n收容所地址：" + self.animals!.address! + "\n\n收容所電話：" + self.animals!.tel! + "\n\n備註：" + self.animals!.remark!
        let url = self.animals!.image!
        let img = UIImageView(frame : CGRect (x: 0, y: 0, width: 50, height: 50))
        img.kf_setImageWithURL(NSURL(string: url)!, placeholderImage: nil, optionsInfo: nil, progressBlock: nil) { (image, error, cacheType, imageURL) in
        let activityController = UIActivityViewController(activityItems:[img.image!,text] , applicationActivities: nil)
        self.presentViewController(activityController, animated: true, completion: nil)
        }
    }
    
    ///ScrollView
    private lazy var scrollView : HomeDetailScrollView = {
        let scrollView = HomeDetailScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        return scrollView
    }()
    
    ///底部欄
    private lazy var toolBarView : HomeDetailToolBar = {
        let toolBarView = NSBundle.mainBundle().loadNibNamed(String(HomeDetailToolBar), owner: nil, options: nil).last as! HomeDetailToolBar
        toolBarView.delegate = self
        return toolBarView
    }()
    
    ///點擊想要收養後
    func toolBarDidClickedTMALLButton() {
        let menu = UIAlertController(title: "帶牠回家步驟", message: "您好，很感謝您想和牠一起開創新生活\n\n（1）確認好您想收養的動物\n\n（2）點擊收容所・詳情\n\n（3）撥打收容所電話確認\n\n（4）最後前往收容所，辦理領養手續。\n\n\n若在\"收容所詳情\"未發現提供電話及地址，需在\"動物詳情\"的備註獲得資訊，謝謝！。", preferredStyle: .Alert)
        let doneAction = UIAlertAction(title: "完成", style: .Cancel, handler: nil)
        menu.addAction(doneAction)
        self.presentViewController(menu, animated: true, completion: nil)
    }
  }

extension HomeDetailViewController : UIScrollViewDelegate{
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var offsetY = scrollView.contentOffset.y
        if offsetY >= 465 {
            offsetY = CGFloat(465)
            scrollView.contentOffset = CGPointMake(0, offsetY)
        }
    }
}
