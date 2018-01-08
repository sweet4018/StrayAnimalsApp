# StrayAnimalsApp
流浪動物app

- Swift2.3
- Xcode7.3.1
- iOS 8
---
### 第三方套件說明：
* Kingfisher：下載和從Web緩存圖像
* SnapKit：自動佈局
* SVProgressHUD：進度顯示
* FDFullscreenPopGesture:使全屏彈出的姿態與AOP的iOS7 +系統的風格
* Alamofire：網路處理
* SwiftyJSON：JSON處理
* MJRefresh：下拉刷新
* SDWebImage:圖片處理

### 第三方套件：
	source 'https://github.com/CocoaPods/Specs.git'
	platform :ios, "8.0"
	use_frameworks!
	target :"StrayAnimals" do
	pod "Kingfisher" , "~>2.6.0"
	pod "SnapKit" , "~>0.22.0"
	pod "SVProgressHUD"
	pod "FDFullscreenPopGesture", "~> 1.1"
	pod "Alamofire"
	pod "SwiftyJSON" , "~> 2.4.0"
	pod "MJRefresh", "~> 3.1.1"
	pod "SDWebImage"
	end
	
###截圖
[架構] <img src ="https://github.com/sweet4018/StrayAnimalsApp/blob/master/image/架構.png">

****
[引導畫面、選擇城市]

!["DemoVideo"](https://github.com/sweet4018/StrayAnimalsApp/blob/master/image/2月-07-2017%2000-08-03.gif)

* 從`AppDelegate.swift`啟動程序
```
	 class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {        
        //創建window
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.makeKeyAndVisible()
        //檢測第一次啟動？
         if !NSUserDefaults.standardUserDefaults().boolForKey(firstLuanch){
            window?.rootViewController = NewfeatureCollectionViewController()
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: firstLuanch)
         }else{
            window?.rootViewController = TabBarController()
        }
        setAppAppearance()
        return true
    }
```
* `TabBar`作法
```
class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAllChildViewController()
        self.setValue(MainTabBar(), forKey: "tabBar")
    }
    private func setUpAllChildViewController(){
        //首頁
        tabBarAddChildViewController(vc: HomeViewController(), title: "首頁", imageName: "recommendation_1", selectedImageName: "recommendation_2")
        //最愛
        tabBarAddChildViewController(vc: FavoriteViewController(), title: "最愛", imageName: "broadwood_1", selectedImageName: "broadwood_2")
        //分類
        tabBarAddChildViewController(vc: ClassifyViewController(), title: "分類", imageName: "classification_1", selectedImageName: "classification_2")
        //我的
        tabBarAddChildViewController(vc: MeViewController(), title: "我的", imageName: "my_1", selectedImageName: "my_2")
    }
    private func tabBarAddChildViewController(vc vc:UIViewController, title:String, imageName:String, selectedImageName:String){
        vc.tabBarItem = UITabBarItem(title: title, image: UIImage(named: imageName), selectedImage: UIImage(named: selectedImageName))
        vc.view.backgroundColor = theme.BackgroundColor
        let nav = NavigationController(rootViewController: vc)
        addChildViewController(nav)
    }   
class MainTabBar : UITabBar {
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.translucent = true
            self.backgroundImage = UIImage(named: "tabbar")
        }
        required init?(coder aDecoder:NSCoder){
            super.init(coder: aDecoder)
        }
    }
}

```
* 則左上角的城市作法是提供一個父類別`MianCityViewController.swift`，設置navigationItem.leftBarButtonItem為自定義的按鈕，並且在viewDidLoad：方法中，添加通知，監聽城市的改變，一旦監聽到當前城市發生改變的通知後，對應的控制器就可以執行對應的操作，需要注意的 每次要將改變後的城市寫入到本地持久化存儲，以便程序被關閉後再次運行時，可以保留上次用戶選擇的城市，選擇城市的控制器是`CityViewController`，城市展示是用UICollectionView，需要注意每次ViewController彈出後，用戶上一次選擇的城市都會自動進入選中狀態，具體實現是拿出上一次用戶選擇的城市，遍歷城市列表取出所屬的indexPath,然後執行下面方法
```
                let lastSelectedCityIndexPaht = selectedCurrentCity()
        collView.selectItemAtIndexPath(lastSelectedCityIndexPaht, animated: true, scrollPosition: UICollectionViewScrollPosition.None)
```
****
[首頁-探索下拉刷新、動物詳情、收容所詳情、撥打電話、分享]

!["DemoVideo"](https://github.com/sweet4018/StrayAnimalsApp/blob/master/image/2月-07-2017%2000-19-13.gif)
* 下拉刷新作法使用第三方套件`MJRefresh`
```
  ///MARK:- 下拉加載刷新數據
        func pullLoadCollection() {
            weak var tmpSelf = self
            // 模擬延時加載
            let time = dispatch_time(DISPATCH_TIME_NOW,Int64(1.0 * Double(NSEC_PER_SEC)))
            SVProgressHUD.showWithStatus("正在加載...")
            dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
                 tmpSelf!.collectionView!.mj_header.endRefreshing()
                 NetworkTool.shareNetworkTool.loadProductData { [weak self] (animals) in
                    if animals.count == 0 {
                        SVProgressHUD.showErrorWithStatus("數據加載失敗")
                        tmpSelf!.collectionView!.mj_header.endRefreshing()
                        return
                    }
                    self!.setupCollectionView()
                    self!.animalsArray = animals
                    self?.collectionView!.reloadData()
                    tmpSelf!.collectionView!.mj_header.endRefreshing()
                }
            }
        }
```
* 導航條上的探索和幫助是將navigationItem.titleView 設置為自定義的`DoubleTextView`來實現，內部封裝好功能，並且通過設置代理將點擊事件傳遞給控制器，在view的最底層添加一個scrollView，設置scorllView的contentSize為屏幕的寬度的2倍，在scrollView上添加倆個TableView，分別是探索的TableView和幫助的TabelView
```
class DoubleTextView: UIView {

    private let leftTextButton: NoHighlightButton =  NoHighlightButton()
    private let rightTextButton: NoHighlightButton = NoHighlightButton()
    private let textColorFroNormal: UIColor = UIColor(red: 100 / 255.0, green: 100 / 255.0, blue: 100 / 255.0, alpha: 1)
    private let textFont: UIFont = theme.NavTitleFont
    private let bottomLineView: UIView = UIView()
    private var selectedBtn: UIButton?
    weak var delegate: DoubleTextViewDelegate?
    
    convenience init(leftText: String, rigthText: String) {
        self.init()
        // 設置左邊文字
        setButton(leftTextButton, title: leftText, tag: 100)
        // 設置右邊文字
        setButton(rightTextButton, title: rigthText, tag: 101)
        // 設置底部線條View
        setBottomLineView()
        titleButtonClick(leftTextButton)
    }
    private func setBottomLineView() {
        bottomLineView.backgroundColor = UIColor(red: 60 / 255.0, green: 60 / 255.0, blue: 60 / 255.0, alpha: 1)
        addSubview(bottomLineView)
    }
    private func setButton(button: UIButton, title: String, tag: Int) {
        button.setTitleColor(UIColor.blackColor(), forState: .Selected)
        button.setTitleColor(textColorFroNormal, forState: .Normal)
        button.titleLabel?.font = textFont
        button.tag = tag
        button.addTarget(self, action: #selector(DoubleTextView.titleButtonClick(_:)), forControlEvents: .TouchUpInside)
        button.setTitle(title, forState: .Normal)
        addSubview(button)
    }
       override func layoutSubviews() {
        super.layoutSubviews()
        let btnW = width * 0.5
        leftTextButton.frame = CGRectMake(0, 0, btnW, height)
        rightTextButton.frame = CGRectMake(btnW, 0, btnW, height)
        bottomLineView.frame = CGRectMake(0, height - 2, btnW, 2)
    }
    func titleButtonClick(sender: UIButton) {
        selectedBtn?.selected = false
        sender.selected = true
        selectedBtn = sender
        bottomViewScrollTo(sender.tag - 100)
        delegate?.doubleTextView(self, didClickBtn: sender, forIndex: sender.tag - 100)
    }    
    func bottomViewScrollTo(index: Int) {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.bottomLineView.frame.origin.x = CGFloat(index) * self.bottomLineView.width
        })
    }    
    func clickBtnToIndex(index: Int) {
        let btn: NoHighlightButton = self.viewWithTag(index + 100) as! NoHighlightButton
        self.titleButtonClick(btn)
    }
}

 ```
* 再來是介紹一下網路處理`NetworkTool`
```
import Foundation
import SVProgressHUD
import Alamofire
import SwiftyJSON

class NetworkTool: NSObject {
    ///單例
    static let shareNetworkTool = NetworkTool()   
    ///讀取公開資料
    func loadProductData(finished:(animals: [Animals]) -> ()) {
        SVProgressHUD.showWithStatus("正在加載...")
        let url = "http://data.coa.gov.tw/Service/OpenData/AnimalOpenData.aspx"
        Alamofire.request(.GET, url).responseJSON { (response) in
                guard response.result.isSuccess else {
                    SVProgressHUD.showErrorWithStatus("加載失敗...")
                    return
                }
                if let value = response.result.value {
                    let dict = JSON(value)
                        if let items = dict.arrayObject {
                            var animalArray = [Animals]()
                            for item in items {
                                    let oneAnimal = Animals(dict: item as! [String: AnyObject])
                                    animalArray.append(oneAnimal)
                                SVProgressHUD.dismiss()
                            }
                            finished(animals: animalArray)
                        }
                }
        }
    }
}
```

****
[首頁-打開地圖、導航、切換行人、汽車模式、路徑步驟]

!["DemoVideo"](https://github.com/sweet4018/StrayAnimalsApp/blob/master/image/2月-07-2017%2000-21-30.gif)

* 地圖方面在`MapViewController`使用MapKit框架，地圖的處理在下面
```
 func mapProcess() {
        let geocoder = CLGeocoder()
        //判斷是否提供地址
        if map != "" {
            //利用Geocoder將地址轉換成座標
            geocoder.geocodeAddressString(map, completionHandler: { placemarks, error in
                if error != nil {
                    print(error)
                    return
                }
                //取得地標
                if let placemarks = placemarks {
                    let placemark = placemarks[0]
                    self.currentPlacemark = placemark
                    //地圖上註解
                    let annotation = MKPointAnnotation()
                    annotation.title = self.name
                    annotation.subtitle = "電話：" + self.tel
                    
                    if let location = placemark.location {
                       annotation.coordinate = location.coordinate
                        
                        self.mapView.showAnnotations([annotation], animated: true)
                        self.mapView.selectAnnotation(annotation, animated: true)
                    }
                }
                })
        }else{
            let noData = UIAlertController(title: "抱歉", message: "本資料尚未提供完全，無法搜尋地點，請嘗試返回，觀看備註是否提供完整聯絡資訊，謝謝！", preferredStyle: .Alert)
            noData.addAction(UIAlertAction(title: "確認", style: .Default, handler: nil))
            self.presentViewController(noData, animated: true, completion: nil)
        }
        
    }

```
****
[首頁-幫助]

!["DemoVideo"](https://github.com/sweet4018/StrayAnimalsApp/blob/master/image/2月-07-2017%2000-23-13.gif)

* 幫助的話設置tableView製作，內容主要都是webView
```
 ///幫助tableView
    private func setalbumTableView() {
        albumTableView = MainTableView(frame: CGRectMake(ScreenWidth, 0, ScreenWidth, backgroundScrollView.height), style: .Plain, dataSource: self, delegate: self)
        backgroundScrollView.addSubview(albumTableView)
        setTableViewHeader(self, refreshingAction: #selector(HomeViewController.pullLoadAlbumData), imageFrame: CGRectMake((ScreenWidth - SD_RefreshImage_Width) * 0.5, 10, SD_RefreshImage_Width, SD_RefreshImage_Height), tableView: albumTableView)
    }
```
****
[我的最愛]

!["DemoVideo"](https://github.com/sweet4018/StrayAnimalsApp/blob/master/image/12月-21-2017%2022-56-40.gif)

* 儲存資料庫的機制是使用```CoreData```，來一段新增資料
```
func insert(entityName: String ,attributeInfo: [String:String],imageData: NSData?) -> Bool {
        
        //先刪除此資料，避免資料重複
        let key: String = attributeInfo["id"]!
        let predicate = NSPredicate(format: "name == %@",key)
        let deleteResult = delete(coreDataEntityAnimal, predicate: predicate)
        print("刪除結果:\(deleteResult)")
        
        let insetData = NSEntityDescription.insertNewObjectForEntityForName("Animal", inManagedObjectContext: self.managedObjectContext) as! MyType
        
        for (key,value) in attributeInfo {
            
            let t = insetData.entity.attributesByName[key]?.attributeType
            
            if t == .Integer16AttributeType  || t == .Integer32AttributeType || t == .Integer64AttributeType {
                
                insetData.setValue(Int(value),forKey: key)
                
            } else if t == .DoubleAttributeType || t == .FloatAttributeType {
                
                insetData.setValue(Double(value),forKey: key)
                
            } else if t == .BooleanAttributeType {
                
                insetData.setValue((value == "true" ? true : false),forKey: key)
            }
            else {
                
                insetData.setValue(value, forKey: key)
            }
        }
        
        //圖片處理
        if let animalImage = imageData {
            
            insetData.image = animalImage
        }
        
        do {
            
            try managedObjectContext.save()
            
            return true
            
        }catch {
            
            fatalError("\(error)")        
        }

        return false
    }
```
****
[分類]

!["DemoVideo"](https://github.com/sweet4018/StrayAnimalsApp/blob/master/image/12月-21-2017%2022-57-25.gif)

* 使用 ```UIPickerView``` 製作，供使用者選擇條件，在搜尋
```
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
```
****
[我的]

!["DemoVideo"](https://github.com/sweet4018/StrayAnimalsApp/blob/master/image/2月-07-2017%2000-24-48.gif)


* 清理內存這裡封裝了一個工具類:FileTool，通過類方法可以調用查看指定路徑文件夾的大小FileTool.folderSize(path: String)，以及異步刪除指路徑下的全部文件夾FileTool.cleanFolder(path: String, complete : () -> ()),complete為刪除完成後的回調
```
 /// 徹底清除文件夾
    class func cleanFolder(path: String, complete:() -> ()) {
        SVProgressHUD.showWithStatus("正在清理內存", maskType: SVProgressHUDMaskType.Clear)
        let queue = dispatch_queue_create("cleanQueue", nil)
        
        dispatch_async(queue) { () -> Void in
            let chilerFiles = self.fileManager.subpathsAtPath(path)
            for fileName in chilerFiles! {
                let tmpPath = path as NSString
                let fileFullPathName = tmpPath.stringByAppendingPathComponent(fileName)
                if self.fileManager.fileExistsAtPath(fileFullPathName) {
                    do {
                        try self.fileManager.removeItemAtPath(fileFullPathName)
                    } catch _ {
                    }
                }
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                SVProgressHUD.dismiss()
                complete()
            })
        }
    }
```

### 作者

* [Chen, Cheng-Yang](https://www.facebook.com/profile.php?id=100000364403933)

* Email:```sweet4018@gmail.com```

### 結語

感謝您的觀看
