//
//  CXLocationViewController.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/8/22.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit
import CoreLocation

class CXLocationViewController: UIViewController {

    
    let locationM = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white

        
        
        
        if #available(iOS 8.0, *) {
            //前后台定位权限
//            locationM.requestWhenInUseAuthorization()
            
            //后台获取用户位置
            locationM.requestAlwaysAuthorization()
            
            
            if #available(iOS 9.0, *) {
                locationM.allowsBackgroundLocationUpdates = true;
            }
            
        }
        
        
        //设置过滤类型
        //每隔100米定位一次
        locationM.distanceFilter = 100
        
        //定位精确度
        //精确度越高，越耗电，定位时间越长
        locationM.desiredAccuracy = kCLLocationAccuracyBest
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        locationM.startUpdatingLocation()
        
        if #available(iOS 9.0, *) {
            locationM.requestLocation()
        } else {
            locationM.startUpdatingLocation()
        }
    }



}

extension CXLocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print("已获取到定位信息")
        
        let newLocation = locations.last
        
        
        
        locationM.stopUpdatingLocation()
    }

    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("用户没有决定")
        case .restricted:
            print("受限制")
        case .authorizedWhenInUse:
            print("前台定位授权")
        case .authorizedAlways:
            print("前后胎定位授权")
        case .denied:
            if CLLocationManager.locationServicesEnabled() {
                print("真正被拒绝")
                //手动通过代码，来跳转到设置界面
                if #available(iOS 8.0, *) {
                    let url = NSURL(string: UIApplicationOpenSettingsURLString)
                    if UIApplication.shared.canOpenURL(url as! URL) {
                        UIApplication.shared.openURL(url as! URL)
                    }
                }
                
                
            } else {
                print("定位服务应该打开")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("定位失败")
    }
}
