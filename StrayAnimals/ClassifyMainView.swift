//
//  ClassifyMainView.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2017/10/15.
//  Copyright © 2017年 ChenZheng-Yang. All rights reserved.
//

import UIKit
import Kingfisher

protocol ClassifyMainViewDelegate: NSObjectProtocol {
    
    ///按鈕點擊
    func buttonDidClicked(button: UIButton)
    
    ///PickerView刷新
    func pickerViewDataUpdate(pickerData: Dictionary<String, String>)
}

class ClassifyMainView: UIView , UIPickerViewDelegate, UIPickerViewDataSource {

    weak var delegate: ClassifyMainViewDelegate?
    
    var titles: [String] = ["縣市","收容所","類型、性別、體型","年紀、是否絕育、是否施打疫苗"]
    
    ///所有資料的字典
    var allDataDic: [String: String] = ["animal_area_pkid": "全部",
                                        "shelter_name": "全部",
                                        "animal_kind": "全部",
                                        "animal_sex": "全部",
                                        "animal_bodytype": "全部",
                                        "animal_age": "全部",
                                        "animal_sterilization": "全部",
                                        "animal_bacterin": "全部"]
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    //MARK: 設置UI
    private func setUI() {
        
        for index in 0..<titles.count {
                        
            let bodyTypeView = setupView(titles[index], tag: index)
            addSubview(bodyTypeView)
        }
        
    }
    
    //MARK: 設置View、Label
    private func setupView(title: String, tag: Int) -> UIView {
        
        let tagCGFloat = CGFloat(tag)
        let view = UIView()
        view.y = (tagCGFloat*150) + (tagCGFloat*20)
        view.width = ScreenWidth
        view.height = 150
        view.backgroundColor = ZYWhileColor()
        
        let titleLabel = setupLabel(title)
        view.addSubview(titleLabel)
        
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: view.bounds.minY+20, width: ScreenWidth, height: 130))
        pickerView.tag = 100+tag
        pickerView.delegate = self
        pickerView.dataSource = self
        view.addSubview(pickerView)
        
        return view
    }

    private func setupLabel(title: String) -> UILabel {
        
        let label = UILabel(frame: CGRectMake(10, 0, ScreenWidth - 10, 40))
        label.text = title
        label.textColor = ZYBlackColor()
        label.font = UIFont.systemFontOfSize(16)
        return label
    }
    
    private func setupButton(index: Int, group:BaseClassify) -> ClassifyVerticalButton {
    
        let btnW: CGFloat = ScreenWidth / 4
        let btnH: CGFloat = btnW
        let labelH: CGFloat = 40
        
        let button = ClassifyVerticalButton()
        button.width = btnW
        button.height = btnH
        button.x = btnW * CGFloat(index % 4)
        button.y = btnH * CGFloat(index / 4) + labelH
        
        if index > 3 {
            button.y = btnH * CGFloat(index / 4) + labelH + kMargin
        }
        
        button.tag = Int(group.ID)!
        button.addTarget(self, action: #selector(groupButtonClick(_:)), forControlEvents: .TouchUpInside)
        button.titleLabel?.font = UIFont.systemFontOfSize(15)
        button.setTitleColor(ZYColor(0, g: 0, b: 0, a: 0.6), forState: .Normal)
        button.setTitle(group.title, forState: .Normal)
        button.setImage(UIImage(named: group.imageName), forState: .Normal)
        
        return button
    }
    
    func groupButtonClick(button: UIButton) {
        delegate?.buttonDidClicked(button)
    }

    
    // MARK: - UIPickerView
    
    //幾列
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        if pickerView.tag == 102 || pickerView.tag == 103{
            return 3
        }
        return 1
    }
    
    //每列需多少行
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 100 {
        
            return cityArr.count
        }else if pickerView.tag == 101 {
            
            return shelterArr.count
        }else if pickerView.tag == 102 {
            
            for index in 0..<type1Arr.count {
                
                if (component == index) {
                    return type1Arr[index].count
                }
            }
        }else if pickerView.tag == 103 {
            for index in 0..<type2Arr.count {
                
                if (component == index) {
                    return type2Arr[index].count
                }
            }
        }
        return 0
    }
    
    // UIPickerView 每個選項顯示的資料
    func pickerView(pickerView: UIPickerView,titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 100 {
            
            if component == 0 {
                return cityArr[row]
            }
            
        }else if pickerView.tag == 101 {
            
            if component == 0 {
                return shelterArr[row]
            }
            
        }else if pickerView.tag == 102 {
            
            for index in 0..<type1Arr.count {
                
                if (component == index) {
                    return type1Arr[index][row]
                }
            }
        }else if pickerView.tag == 103 {
            
            for index in 0..<type2Arr.count {
                
                if (component == index) {
                    return type2Arr[index][row]
                }
                
            }
        }
        return ""
    }
    
    // UIPickerView 改變選擇後執行的動作
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        var resultDataArr: Array = [String]()
        
        if pickerView.tag == 100 {
            
            if component == 0 {
                resultDataArr.append(cityArr[row])
                allDataDic["animal_area_pkid"] = String(row + 1)
            }
            
        }else if pickerView.tag == 101 {
            
            if component == 0 {
                resultDataArr.append(shelterArr[row])
                
                /*
                var add: Int = 47
                
                if row == 40 {
                    add = 54
                }else if row > 35 && row < 40{
                    add = 53
                }
                 allDataDic["shelter_name"] = String(row + add)
                */
                allDataDic["shelter_name"] = shelterArr[row]
            }
            
        }else if pickerView.tag == 102 {
            
            for index in 0..<type1Arr.count {
                
                if (component == index) {
                    resultDataArr.append(type1Arr[index][row])
                }
                
                if (component == 0) {
                    let bodyTypeArr: Array = ["全部","MINI","SMALL","MEDIUM","BIG"]
                    allDataDic["animal_bodytype"] = bodyTypeArr[row]
                }else if (component == 1) {
                    let sexArr: Array = ["全部","M","F","N"]
                    allDataDic["animal_sex"] = sexArr[row]
                }else if (component == 2) {
                    allDataDic["animal_kind"] = type1Arr[component][row]
                }
                
            }
        }else if pickerView.tag == 103 {
            
            for index in 0..<type2Arr.count {
                
                if (component == index) {
                    resultDataArr.append(type2Arr[index][row])
                }
                let arr: Array = ["全部","T","F","N"]
                if (component == 0) {
                    let ageArr: Array = ["全部","CHILD","ADULT"]
                    allDataDic["animal_age"] = ageArr[row]
                }else if (component == 1) {
                    allDataDic["animal_sterilization"] = arr[row]
                }else if (component == 2) {
                    allDataDic["animal_bacterin"] = arr[row]
                }
            }
        }
        
        delegate?.pickerViewDataUpdate(allDataDic)
        print("剛剛刷新了什麼：\(resultDataArr)")
    }
}
