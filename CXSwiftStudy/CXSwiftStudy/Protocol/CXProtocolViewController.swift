//
//  CXProtocolViewController.swift
//  CXSwiftStudy
//
//  Created by ymh on 2018/4/12.
//  Copyright © 2018年 CX. All rights reserved.
//

import UIKit

protocol MessageModelProtocol {
    var name: String {get set}
    var age: Int {get set}
    
}

struct MessageModel: MessageModelProtocol {
    
    var name: String
    
    var age: Int
    
    
}

class FoodImageView: UIImageView, CXShakeableProtocol {
    
}


// ProtocolTableViewCell
class ProtocolTableViewCell: UITableViewCell {
    
}



class CXProtocolViewController: CXBaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    let imageview = FoodImageView()
    
    var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.registerCell()
        
        let array = [1, 2, 3, 4, 5]
        
        print(array.sum())
    }
    
    func registerCell() {
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        
        tableView.register(ProtocolTableViewCell.self)
    }
    
    // MAKR: UITableViewDataSource/Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath as NSIndexPath) as ProtocolTableViewCell
        
        let cell = ProtocolTableViewCell()
        cell.textLabel?.text = "请点击我啊！"
        
        return cell
    }
    
    func addSubViews() {
        imageview.frame = CGRect(x: 50, y: 100, width: 200, height: 250)
        imageview.image = #imageLiteral(resourceName: "invite_background")
        self.view.addSubview(imageview)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        imageview.shake()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension Array where Element: Numeric {
    func sum() -> Element {
        return reduce(0, +)
    }
}

// MARK: --- UITableViewCell ---
extension UITableViewCell: ReusableViewProtocol, NibLoadableViewProtocol {}

// MARK: --- UITableView ---
extension UITableView {
    func register<T: UITableViewCell>(_ : T.Type) where T: ReusableViewProtocol, T: NibLoadableViewProtocol {
        let Nib = UINib(nibName: T.NibName, bundle: nil)
        
        register(Nib, forCellReuseIdentifier: T.reuseIdentifier)
        
    }
}

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: NSIndexPath) -> T where T: ReusableViewProtocol {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath as IndexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        
        return cell
    }
}


