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
****
[首頁-探索下拉刷新、動物詳情、收容所詳情、撥打電話、分享]

<img src="https://github.com/sweet4018/StrayAnimalsApp/blob/master/image/2月-06-2017%2014-31-40.gif" , height=500>

****
[首頁-打開地圖、導航、切換行人、汽車模式、路徑步驟]

<img src="https://github.com/sweet4018/StrayAnimalsApp/blob/master/image/2月-06-2017%2014-39-28.gif" , height=500>

****
[首頁-幫助]

<img src="https://github.com/sweet4018/StrayAnimalsApp/blob/master/image/2月-06-2017%2014-41-10.gif" , height=500>

****
[我的]

<img src="https://github.com/sweet4018/StrayAnimalsApp/blob/master/image/2月-06-2017%2014-46-06.gif" , height=500>
