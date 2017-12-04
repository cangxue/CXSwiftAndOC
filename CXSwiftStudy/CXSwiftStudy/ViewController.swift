//
//  ViewController.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 17/4/12.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView!
    
    lazy var showArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.showArray = ["CXDesignViewController", "CXMVCViewController"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func collectionBtnClick(_ sender: Any) {
        let vc = CollectionViewController()
        vc.title = "Collection"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func blockBtnClick(_ sender: Any) {
        let vc = CXBlockViewController()
        vc.title = "Block"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func locationBtnClick(_ sender: Any) {
        let vc = CXLocationViewController()
        vc.title = "Location"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - 代理方法
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.showArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "cellID"
        let cell:UITableViewCell = UITableViewCell.init(style: .default, reuseIdentifier: cellId)
        cell.selectionStyle = .none
        cell.textLabel?.text = self.showArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //1:动态获取命名空间
        guard   let name = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
            return
        }
        
        let VCName = self.showArray[indexPath.row]
        
        let cls: AnyClass? = NSClassFromString(name + "." + VCName) //VCName:表示试图控制器的类名
        
        // Swift中如果想通过一个Class来创建一个对象, 必须告诉系统这个Class的确切类型
        guard let typeClass = cls as? UIViewController.Type else {
            return
        }
        
        let childController = typeClass.init()
        
        childController.title = self.showArray[indexPath.row]
        self.navigationController?.pushViewController(childController, animated: true)
    }
}
