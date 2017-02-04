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
        view.backgroundColor = ZYGrayColor()
        ///初始化導航列
        setNav()
        ///設置留言框及聯絡方式框
        setFeedbackTextViewAndContactTextField()
    }
    private func setFeedbackTextViewAndContactTextField() {
        let backView = UIView(frame: CGRectMake(0, 5, ScreenWidth, 130))
        backView.backgroundColor = ZYGrayColor()
        feedbackTextView = UITextView(frame: CGRectMake(5, 0, ScreenWidth - 10, 250))
        feedbackTextView.backgroundColor = ZYWhileColor()
        feedbackTextView.font = UIFont.systemFontOfSize(20)
        feedbackTextView.allowsEditingTextAttributes = true
        feedbackTextView.autocorrectionType = UITextAutocorrectionType.No
        backView.addSubview(feedbackTextView!)
        view.addSubview(backView)
        
        contactTextField = UITextField(frame: CGRectMake(0, CGRectGetMaxY(feedbackTextView.frame) + 10, ScreenWidth, 50))
        contactTextField.clearButtonMode = UITextFieldViewMode.Always
        contactTextField.backgroundColor = ZYWhileColor()
        contactTextField.font = UIFont.systemFontOfSize(18)
        let leffView = UIView(frame: CGRectMake(0, 0, 10, 20))
        contactTextField.leftView = leffView
        contactTextField.leftViewMode = UITextFieldViewMode.Always
        contactTextField.placeholder = "留下郵箱或電話，以方便我們給您回覆"
        contactTextField.autocorrectionType = UITextAutocorrectionType.No
        contactTextField.delegate = self
        view.addSubview(contactTextField)
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
        if contactStr!.validateEmail()||contactStr!.validateMobile() {
            alertView = UIAlertView(title: "提示", message: "感謝您的意見回饋", delegate: nil, cancelButtonTitle: "完成")
            alertView?.show()
            self.navigationController?.popViewControllerAnimated(true)
            return
        } else {
            alertView = UIAlertView(title: "提示", message: "請您輸入正確的聯絡方式，以便我們給您回覆", delegate: nil, cancelButtonTitle: "完成")
            alertView?.show()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        feedbackTextView.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        sendClick()
        return true
    }
    deinit {
        print("回饋留言ViewController已銷毀", terminator : "")
    }
    
}
