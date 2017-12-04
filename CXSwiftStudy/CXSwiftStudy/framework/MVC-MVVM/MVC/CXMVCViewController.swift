//
//  CXMVCViewController.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/12/4.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

class CXMVCViewController: CXBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let model = CXMVCModel(name: "Robert", age: 10)
        
        let view = CXMVCView(frame: CGRect(x: 0, y: 70, width: 300, height: 150))
        self.view.addSubview(view)
        
        let controller = CXMVCController(model: model, view: view)
        controller.updateView()
        
        controller.setModelName(name: "Bob")
        controller.updateView()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
