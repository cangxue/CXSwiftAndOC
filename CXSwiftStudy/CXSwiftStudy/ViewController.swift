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
        
        self.showArray = ["basic"]
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
        var vc = UIViewController()
        switch indexPath.row {
        case 0:
            vc = BasicViewController()
            
        default:
            vc = UIViewController()
        }
        
        vc.title = self.showArray[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
