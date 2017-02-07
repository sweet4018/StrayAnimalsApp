//
//  MapNavigatorViewController.swift
//  StrayAnimals
//
//  Created by ChenZheng-Yang on 2016/10/8.
//  Copyright © 2016年 ChenZheng-Yang. All rights reserved.
//

import UIKit
import MapKit
import SVProgressHUD

public let SD_DetailCell_Identifier = "DetailCell"

class MapViewController: UIViewController , MKMapViewDelegate{
    
    var map:String = ""
    var name:String = ""
    var tel:String = ""
    var image:String = ""
    
    var routeSteps = [MKRouteStep]()
    
    //使用者位置
    var currentPlacemark:CLPlacemark?
    let locationManager = CLLocationManager()
    
    var currentTransportType = MKDirectionsTransportType.Automobile
    var currentRoute:MKRoute?
    
    var model : Animals? {
        didSet {
            self.map = (model?.address!)!
            self.name = (model?.name!)!
            self.tel = (model?.tel!)!
            self.image = (model?.image!)!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化
        setupUI()
        navigationMap()
        //導航列
        setupBarButtonItem()
        //地圖處理
        mapProcess()
        //導航模式按鈕
        navigationModeBtn()
        modeBtn.hidden = true
        //導航步驟
        routeStepBtn()
        routeBtn.hidden = true
        
    }
    //MARK:-懶加載屬性
    private lazy var backView: UIView = {
        let backView = UIView(frame: MainBounds)
        backView.backgroundColor = ZYWhileColor()
        return backView
    }()
    ///地圖
    private lazy var mapView : MKMapView = {
        let mapView = MKMapView()
        mapView.frame = MainBounds
        mapView.delegate = self
        mapView.showsUserLocation = true
        return mapView
    }()
    ///路徑步驟
    private lazy var routeTableView: MainTableView = {
        let tableView = MainTableView(frame: MainBounds, style: .Plain, dataSource: self, delegate: self)
        tableView.rowHeight = DetailCellHeight
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: NavigationH, right: 0)
        tableView.registerNib(UINib(nibName: "MapTableViewCell", bundle: nil), forCellReuseIdentifier: SD_DetailCell_Identifier)
        return tableView
    }()
    
    private var modeBtn: UIButton! = UIButton()
    private var routeBtn : UIButton! = UIButton()
    
    private func setupUI() {
        view.backgroundColor = UIColor.whiteColor()
        view.addSubview(backView)
        backView.addSubview(routeTableView)
        backView.addSubview(mapView)
        
    }
    
    private func navigationModeBtn() {
        let btnWH:CGFloat = NavigationH
        modeBtn.frame = CGRectMake(ScreenWidth-btnWH, ScreenHeight-(btnWH*2+10), btnWH, btnWH)
        modeBtn.setImage(UIImage(named: "walk"), forState: .Normal)
        modeBtn.setImage(UIImage(named: "car"), forState: .Selected)
        modeBtn.addTarget(self, action: #selector(MapViewController.modeClick(_:)), forControlEvents: .TouchUpInside)
        view.addSubview(modeBtn)
    }
    
    private func routeStepBtn() {
        let btnWH:CGFloat = NavigationH
        routeBtn.frame = CGRectMake(ScreenWidth-btnWH, ScreenHeight-(btnWH*3+10), btnWH, btnWH)
        routeBtn.setImage(UIImage(named: "themelist"), forState: .Normal)
        routeBtn.setImage(UIImage(named: "mapicon"), forState: .Selected)
        routeBtn.addTarget(self, action: #selector(MapViewController.routeClick(_:)), forControlEvents: .TouchUpInside)
        view.addSubview(routeBtn)
    }
    
    func modeClick(sender: UIButton) {
        sender.selected = !sender.selected
        if sender.selected {
            title = "步行路線"
            currentTransportType = MKDirectionsTransportType.Walking
            directionButtonClick()
            self.routeTableView.reloadData()
            
        } else {
            title = "汽車路線"
            currentTransportType = MKDirectionsTransportType.Automobile
            directionButtonClick()
            self.routeTableView.reloadData()
        }
    }
    
    func routeClick(sender: UIButton) {
        sender.selected = !sender.selected
        if sender.selected {
             UIView.transitionFromView(mapView, toView: routeTableView, duration: 1.0, options: UIViewAnimationOptions.TransitionFlipFromLeft, completion:nil)
            self.routeTableView.reloadData()
        } else {
            UIView.transitionFromView(routeTableView, toView: mapView, duration: 1.0, options: UIViewAnimationOptions.TransitionFlipFromRight, completion: nil)
        }
    }
    

    ///導航要求
    func navigationMap() {
        //請求使用者授權使用定位服務
        locationManager.requestWhenInUseAuthorization()
        let status = CLLocationManager.authorizationStatus()
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            self.mapView.showsUserLocation = true
        }
    }
    
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
    
    // MARK: - 設置導航列按鈕
    private func setupBarButtonItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: .Plain, target: self, action: #selector(cancelButtonClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "導航", style: .Plain, target: self, action: #selector(directionButtonClick))
    }
    
    /// 返回按鈕點擊
    func cancelButtonClick() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    /// 導航按鈕點擊
    func directionButtonClick() {
        SVProgressHUD.showWithStatus("尋找最佳路線中...")
        self.routeTableView.reloadData()
        let directionRequest = MKDirectionsRequest()
        //設定路徑起始與目的地
        directionRequest.source = MKMapItem.mapItemForCurrentLocation()
        let destinationPlacemark = MKPlacemark(placemark: currentPlacemark!)
        directionRequest.destination = MKMapItem(placemark: destinationPlacemark)
        directionRequest.transportType = currentTransportType
        //方向計算
        let directions = MKDirections(request: directionRequest)
        directions.calculateDirectionsWithCompletionHandler { (routeResponse, routeError) -> Void in
            guard let routeResponse = routeResponse else {
                if let routeError = routeError {
                    print("Erro:\(routeError)")
                     SVProgressHUD.dismiss()
                    let noDirectionPlacemark = UIAlertController(title: "未偵測到您當前位置", message: "請檢查是否開啟定位功能", preferredStyle: .Alert)
                    noDirectionPlacemark.addAction(UIAlertAction(title: "確認", style: .Default, handler: nil))
                    self.presentViewController(noDirectionPlacemark, animated: true, completion: nil)
                }
                return
            }
            self.modeBtn.hidden = false
            self.routeBtn.hidden = false
            let route = routeResponse.routes[0]
            self.currentRoute = route
            if let steps = self.currentRoute?.steps {
                self.routeSteps = steps
            }
            self.mapView.removeOverlays(self.mapView.overlays)
            self.mapView.addOverlay(route.polyline,level: MKOverlayLevel.AboveRoads)
            //縮放
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
            SVProgressHUD.dismiss()
        }
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyPin"
        if annotation.isKindOfClass(MKUserLocation){
            return nil
        }
        var annotationView:MKPinAnnotationView? = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        let LeftIconView = UIImageView(frame: CGRectMake(0, 0, 60, 60))
        let Image = self.image
        let url = NSURL(string: Image )
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let data = NSData(contentsOfURL: url!)
            dispatch_async(dispatch_get_main_queue(),{LeftIconView.image = UIImage(data: data!)})
        }
        annotationView?.leftCalloutAccessoryView = LeftIconView
        return annotationView
    }
    
    //繪製路徑
    func mapView(mapView: MKMapView, rendererForOverlay overlay :MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = (currentTransportType == .Automobile) ? UIColor.blueColor() : UIColor.orangeColor()
        renderer.lineWidth = 3.0
        return renderer
    }
}

extension MapViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routeSteps.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(SD_DetailCell_Identifier) as! MapTableViewCell
        cell.detailLabel!.text = routeSteps[indexPath.row].instructions
        return cell
    }
}

