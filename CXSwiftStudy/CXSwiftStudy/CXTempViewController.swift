//
//  CXTempViewController.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/11/7.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

class CXTempViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        //简单工厂模式
        print("============= 简单工厂模式 =================")
        let cheeseBurger = CXCheeseBurgerFactory().createFood()
        cheeseBurger.printFood()
        print(cheeseBurger.type)
        
        let chipsSnack = CXChipsSnackFactory().createFood()
        chipsSnack.printFood()
        print(chipsSnack.type)
        
        //抽象工厂模式
        print("============= 抽象工厂模式 =================")
        let burger = CXBurgerFactory().createFoodAndParameters(type: "Cheese")
        burger.printFood()
        print(burger.type)
        
        let snack = CXFoodFactory().createFoodAndParameters(type: "Chips")
        snack.printFood()
        print(snack.type)
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
