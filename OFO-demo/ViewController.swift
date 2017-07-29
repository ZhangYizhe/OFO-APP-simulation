//
//  ViewController.swift
//  OFO-demo
//
//  Created by 张艺哲 on 2017/7/26.
//  Copyright © 2017年 张艺哲. All rights reserved.
//

import UIKit
import SWRevealViewController
import FTIndicator


class ViewController: UIViewController,MAMapViewDelegate,AMapSearchDelegate,AMapNaviWalkManagerDelegate {
    
    var mapView:MAMapView!
    var search:AMapSearchAPI!
    var pin : MyPinAnnotation!
    var pinView : MAAnnotationView!
    var nearBySearch = true
    
    //导航起点与终点
    
    var start,end : CLLocationCoordinate2D!
    var walkManager:AMapNaviWalkManager!
    
    //定位按钮出发判断
    var localtionBtn = false
    
    @IBOutlet weak var MapMainView: UIView!//地图容器
    
    
    
    @IBOutlet weak var panelView: UIStackView!
    @IBAction func localtionBtnTap(_ sender: UIButton) {
        localtionBtn = true
        searchBikeNearby()

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        mapView = MAMapView(frame: MapMainView.bounds)
        MapMainView.addSubview(mapView)
        
        mapView.delegate = self
        mapView.zoomLevel = 17
        
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        search = AMapSearchAPI()
        search.delegate = self
        

        walkManager = AMapNaviWalkManager()
        walkManager.delegate = self
        
        
        view.bringSubview(toFront: panelView)
        
        self.navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "ofoLogo"))
        self.navigationItem.leftBarButtonItem?.image = #imageLiteral(resourceName: "leftTopImage").withRenderingMode(.alwaysOriginal)
        self.navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "rightTopImage").withRenderingMode(.alwaysOriginal)
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        
        
        //启动容器包含两部分
        
        if let revealVC = revealViewController() {
            
            revealVC.rearViewRevealWidth = 280
            
            navigationItem.leftBarButtonItem?.target = revealVC
            navigationItem.leftBarButtonItem?.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - 大头针动画
    
    func pinAnimation(){
        
        //坠落效果 y轴+位移
        
        let endFrame = pinView.frame
        
        pinView.frame = endFrame.offsetBy(dx: 0, dy: -15)
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0, options: [], animations: { 
            
            self.pinView.frame = endFrame
            
        }, completion: nil)
        
        
        
    }
    
    // MARK: - MapView Delegate
    
    func mapView(_ mapView: MAMapView!, rendererFor overlay: MAOverlay!) -> MAOverlayRenderer! {
        if overlay.isKind(of: MAPolyline.self){
            
            pin.isLockedToScreen = false
            
            mapView.visibleMapRect = overlay.boundingMapRect
            
            let renderer:MAPolylineRenderer = MAPolylineRenderer(overlay: overlay)
            renderer.lineWidth = 8.0
            renderer.strokeColor = UIColor.red
            
            return renderer
        }
        return nil
    }
    
    
    func mapView(_ mapView: MAMapView!, didAddAnnotationViews views: [Any]!) {
        
        let aViews = views as! [MAAnnotationView]
        
        for aView in aViews {
            guard aView.annotation is MAPinAnnotationView else {
                continue
            }
            
            aView.transform = CGAffineTransform(scaleX: 0, y: 0)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0, options: [], animations: { 
                
                aView.transform = .identity
                
            }, completion: nil)
        }
        
    }
    
    func mapView(_ mapView: MAMapView!, didSelect view: MAAnnotationView!) {
        
        start = pin.coordinate
        end = view.annotation.coordinate
        
        let startPoint = AMapNaviPoint.location(withLatitude: CGFloat(start.latitude), longitude: CGFloat(start.longitude))!
        let endPoint = AMapNaviPoint.location(withLatitude: CGFloat(end.latitude), longitude: CGFloat(end.longitude))!
        
        walkManager.calculateWalkRoute(withStart: [startPoint], end: [endPoint])
        
    }
    
    
    ///地图初始化完成后
    func mapInitComplete(_ mapView: MAMapView!) {
        pin = MyPinAnnotation()
        pin.coordinate = mapView.centerCoordinate
        pin.lockedScreenPoint = CGPoint(x: MapMainView.bounds.width/2, y: MapMainView.bounds.height/2)
        pin.isLockedToScreen = true
        
        mapView.addAnnotation(pin)
        mapView.showAnnotations([pin], animated: true)
        
        searchBikeNearby()
    }
    
    //用户移动地图的交互
    func mapView(_ mapView: MAMapView!, mapDidMoveByUser wasUserAction: Bool) {
        if wasUserAction {
            pin.isLockedToScreen = true
            pinAnimation()
            searchCustomLocation(mapView.centerCoordinate)
            
        }
    }
    
    

    
    
    
    ///自定义大头针视图
    
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        
        //用户定位的位置不需要自定义
        if annotation is MAUserLocation{
            return nil
        }
        
        if annotation is MyPinAnnotation{
            let reuseid = "anchor"
            var av = mapView.dequeueReusableAnnotationView(withIdentifier: reuseid) as? MAPinAnnotationView
            if av == nil{
                av = MAPinAnnotationView(annotation: annotation, reuseIdentifier: reuseid)
            }
            
            av?.image = #imageLiteral(resourceName: "homePage_wholeAnchor")
            av?.canShowCallout = false
            av?.animatesDrop = true
            
            pinView = av
            return av
        }
        
        let reuseid = "myid"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseid) as? MAPinAnnotationView
        
        if annotationView == nil{
            annotationView = MAPinAnnotationView(annotation: annotation, reuseIdentifier: reuseid)
        }
        
        if annotation.title == "正常可用" {
            annotationView?.image = #imageLiteral(resourceName: "HomePage_nearbyBike")
        } else {
            annotationView?.image = #imageLiteral(resourceName: "HomePage_nearbyBikeRedPacket")
        }
        
        annotationView?.canShowCallout = true
        annotationView?.animatesDrop  = true
        
        return annotationView
        
    }
    
    // MARK: - Map Search Delegate
    
    //搜索周边的小黄车请求
    func searchBikeNearby() {
        searchCustomLocation(mapView.userLocation.coordinate)
        
    }
    
    func searchCustomLocation(_ center:CLLocationCoordinate2D) {
        let request = AMapPOIAroundSearchRequest()
        request.location = AMapGeoPoint.location(withLatitude: CGFloat(center.latitude), longitude: CGFloat(center.longitude))
        request.keywords = "餐馆"
        request.radius = 500
        request.requireExtension = true
        
        search.aMapPOIAroundSearch(request)
    }
    
    //搜索周边完成后回调处理
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        
        guard response.count > 0 else {
            print("周边没有小黄车")
            return
        }
        
        var annotations : [MAPointAnnotation] = []
        
        annotations = response.pois.map{
            
            let annotation = MAPointAnnotation()
            
            annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees($0.location.latitude), longitude: CLLocationDegrees($0.location.longitude))
            
            if $0.distance < 200 {
                annotation.title = "红包区域开锁任意小黄车"
                annotation.subtitle = "骑行10分钟可获得现金红包"
            }else{
                annotation.title = "正常可用"
            }
            
            
            return  annotation
            
        }
        
        mapView.addAnnotations(annotations)
        
        if nearBySearch {
           mapView.showAnnotations(annotations, animated: true)
            nearBySearch = !nearBySearch
        }
        
        if localtionBtn{
            mapView.showAnnotations(annotations, animated: true)
            localtionBtn = false
        }
        
        

        
    }
    
    
    //MARK: - 导航代理
    func walkManager(onCalculateRouteSuccess walkManager: AMapNaviWalkManager) {

        mapView.removeOverlays(mapView.overlays)
        
        var coordinates = walkManager.naviRoute!.routeCoordinates!.map {
            return CLLocationCoordinate2D(latitude: CLLocationDegrees($0.latitude), longitude: CLLocationDegrees($0.longitude))
        }
        
        let polyline = MAPolyline(coordinates: &coordinates, count: UInt(coordinates.count))
        
        mapView.add(polyline)
        
        //提示距离与时间
        
        let walkMinut = walkManager.naviRoute!.routeTime / 60
        
        var timeDesc = "1分钟以内"
        if walkMinut > 0{
            timeDesc = walkMinut.description+"分钟"
        }
        
        let hinTitle = "步行" + timeDesc
        let hinSubtitle = "距离" + walkManager.naviRoute!.routeLength.description + "米"
        
//        let ac = UIAlertController(title: hinTitle, message: hinSubtitle, preferredStyle: .alert)
//        let action = UIAlertAction(title: "ok", style: .default, handler: nil)
//        
//        ac.addAction(action)
//        
//        self.present(ac, animated: true, completion: nil)
        
        FTIndicator.setIndicatorStyle(.dark)
        FTIndicator.showNotification(with: #imageLiteral(resourceName: "clock"), title: hinTitle, message: hinSubtitle)
        
    }



}





