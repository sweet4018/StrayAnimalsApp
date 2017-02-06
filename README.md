# StrayAnimalsApp
流浪動物app

- 使用swift2.3,Xcode7.3.1製作
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
	
##截圖
[架構] <img src ="https://github.com/sweet4018/StrayAnimalsApp/blob/master/image/架構.png">

****
[引導畫面、選擇城市]

<img src="https://github.com/sweet4018/StrayAnimalsApp/blob/master/image/2月-06-2017%2012-16-47.gif" , height=500>	
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

<img src="https://github.com/sweet4018/StrayAnimalsApp/blob/master/image/2月-06-2017%2014-31-40.gif" , height=500>

* 導航條上的探索和幫助是將navigationItem.titleView 設置為自定義的`DoubleTextView`來實現,內部封裝好功能,並且通過設置代理將點擊事件傳遞給控制器，在view的最底層添加一個scrollView，設置scorllView的contentSize為屏幕的寬度的2倍，在scrollView上添加倆個TableView，分別是探索的TableView和幫助的TabelView
****
[首頁-打開地圖、導航、切換行人、汽車模式、路徑步驟]

<img src="https://github.com/sweet4018/StrayAnimalsApp/blob/master/image/2月-06-2017%2014-39-28.gif" , height=500>

****
[首頁-幫助]

<img src="https://github.com/sweet4018/StrayAnimalsApp/blob/master/image/2月-06-2017%2014-41-10.gif" , height=500>

****
[我的]

<img src="https://github.com/sweet4018/StrayAnimalsApp/blob/master/image/2月-06-2017%2014-46-06.gif" , height=500>

* 清理內存這裡封裝了一個工具類:FileTool，通過類方法可以調用查看指定路徑文件夾的大小FileTool.folderSize(path: String)，以及異步刪除指路徑下的全部文件夾FileTool.cleanFolder(path: String, complete : () -> ()),complete為刪除完成後的回調
