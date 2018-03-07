//
//  CXSnapKitViewController.swift
//  CXSwiftStudy
//
//  Created by ymh on 2018/3/7.
//  Copyright © 2018年 CX. All rights reserved.
//

import UIKit
import SnapKit
import WebKit

class CXSnapKitViewController: UIViewController {
    
    private var box: UIView!
    
    private var mainWebView: WKWebView!
    
    lazy var tableView = UITableView()


    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        self.mainTableView()
    }
    
    func mainTableView() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(self.bottomLayoutGuide.snp.top)
        }
    }

    func boxView() {
        
        box = UIView(frame: CGRect())
        
        self.view.addSubview(box)
        box.backgroundColor = UIColor.blue
        box.snp.makeConstraints { (make) in
            make.width.height.equalTo(100)
            make.center.equalTo(self.view)
        }
    }
    
    func webView() {
        mainWebView = WKWebView(frame: CGRect(), configuration: WKWebViewConfiguration())
//        mainWebView.frame = view.bounds
        mainWebView.navigationDelegate = self
        
        self.view.addSubview(mainWebView)
        mainWebView.snp.makeConstraints({ (make) in
            
            make.top.equalTo(view.snp.top)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-49)
            
        })
        
        
        let url = URL.init(string: "https://www.baidu.com")
        let request = URLRequest.init(url: url!)
        mainWebView.load(request)
    }

}

extension CXSnapKitViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("webViewDidStartLoad")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("webViewDidFinishLoad")
    }
}
