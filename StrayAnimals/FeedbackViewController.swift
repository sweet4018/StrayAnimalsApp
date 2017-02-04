//
//  FeedBackViewController.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2017/2/3.
//  Copyright © 2017年 ChenZheng-Yang. All rights reserved.
//

import UIKit

class FeedBackViewController: UIViewController,UITextFieldDelegate {

    ///留言TextView
    private var feedbackTextView:UITextView!
    ///聯絡方式TextField
    private var contactTextField:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func setNav() {
        self.navigationItem.title = "留言回饋"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "發送", style: UIBarButtonItemStyle.Done, target: self, action: #selector(FeedBackViewController.sendClick))
    }
    
    func sendClick() {
        let contactStr = contactTextField.text
        var alertView:UIAlertView?
        
        if feedbackTextView.text.isEmpty {
            alertView = UIAlertView(title: "提示", message: "請填寫您的意見回饋", delegate: nil, cancelButtonTitle: "完成")
            alertView?.show()
            return
        }
    }
    
    
}
