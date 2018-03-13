//
//  CXRxSwiftViewController.swift
//  CXSwiftStudy
//
//  Created by ymh on 2018/3/7.
//  Copyright © 2018年 CX. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class CXRxSwiftViewController: CXBaseViewController {
    
    //tableView对象
    var tableView: UITableView!
    
    //列表数据源
    let childViewModel = ChildViewModel()
    
    //负责对象销毁
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "RxSwift"
        
        //设置tableview
        tableView = UITableView(frame: view.bounds, style: .plain)
        //创建重用cell
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "childCell")
        self.view.addSubview(tableView)
        
        //将数据源数据绑定到tableview上
        childViewModel.data.bind(to: tableView.rx.items(cellIdentifier: "childCell")) { _, child, cell in
            cell.textLabel?.text = child.name
            cell.detailTextLabel?.text = child.title
        }.disposed(by: disposeBag)
        
        //tableview点击响应
        tableView.rx.modelSelected(ChildVC.self).subscribe(onNext: { (child) in
            //1:动态获取命名空间
            guard   let name = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
                return
            }
            
            let VCName = child.name
            
            let cls: AnyClass? = NSClassFromString(name + "." + VCName) //VCName:表示试图控制器的类名
            
            // Swift中如果想通过一个Class来创建一个对象, 必须告诉系统这个Class的确切类型
            guard let typeClass = cls as? UIViewController.Type else {
                return
            }
            
            let childController = typeClass.init()
            childController.title = child.title
            self.navigationController?.pushViewController(childController, animated: true)
        }).disposed(by: disposeBag)
        
    }

}

//子控制器结构体
struct ChildVC {
    let name: String //名称
    let title: String //标题
    init(name: String, title: String) {
        self.name = name
        self.title = title
    }
}

//列表数据源
struct ChildViewModel {
    let data = Observable.just([
        
        ChildVC(name: "CXTextFieldViewController", title: "Text"),
        ChildVC(name: "CXUILabelViewController", title: "UILabel"),
        ChildVC(name: "CXTraitsViewController", title: "Traits"),
        ChildVC(name: "CXObservableViewController", title: "Observalbe"),
        ChildVC(name: "CXUIButtonViewController", title: "Button"),
        ])
}


