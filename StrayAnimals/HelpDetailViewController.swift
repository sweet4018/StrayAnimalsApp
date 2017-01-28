//
//  HelpViewController.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2016/10/6.
//  Copyright © 2016年 ChenZheng-Yang. All rights reserved.
//

import UIKit

class HelpDetailViewController: UIViewController,UIWebViewDelegate {

    
    var helpModel:ThemeModel? {
        didSet{
            if helpModel?.hasweb == 1 {
                self.webView?.loadRequest(NSURLRequest(URL: NSURL(string: helpModel!.themeurl!)!))
                title = helpModel?.text
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
    }
    //MARK:- 懶加載屬性
    private lazy var backView : UIView = {
        let backView = UIView(frame: MainBounds)
        backView.backgroundColor = ZYWhileColor()
        return backView
    }()
    
    private lazy var webView : UIWebView? = {
        let web = UIWebView(frame: MainBounds)
        web.backgroundColor = ZYWhileColor()
        web.scalesPageToFit = true
        web.dataDetectorTypes = .All
        web.delegate = self
        return web
    }()
    
    private func setUpUI() {
        view.backgroundColor = ZYWhileColor()
        view.addSubview(backView)
        backView.addSubview(webView!)
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "share_1", highlImageName: "share_2", targer: self, action: #selector(HelpDetailViewController.shareBtn))
    }
    //分享按鈕
    func shareBtn() {
        let text = "標題：" + helpModel!.title! + "\n\n網址：" + helpModel!.themeurl!
        let activityController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        self.presentViewController(activityController, animated: true, completion: nil)
    }
    
    /// WebViewDelegate
    func webViewDidFinishLoad(webView: UIWebView) {
        self.webView!.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 64, right: 0)
    }
    

}
