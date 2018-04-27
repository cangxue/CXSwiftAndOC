//
// Created by ymh on 2018/4/27.
// Copyright (c) 2018 CX. All rights reserved.
//


import UIKit
import RxCocoa
import RxSwift

class CXSliderViewController: CXBaseViewController {

    let disposeBag = DisposeBag()

    let slider = UISlider()

    let stepper = UIStepper()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sliderMethod()
        
    }
    
    func sliderMethod() {
        
        slider.frame = CGRect(x: 20, y: 80, width: 100, height: 30)
        slider.value = 0.1
        view.addSubview(slider)

//        slider.rx.value.asObservable()
//                .subscribe(onNext: {
//                      print("当前值为：\($0)")
//                 })
//                .disposed(by: disposeBag)

        stepper.frame = CGRect(x: 20, y: 120, width: 100, height: 30)
        stepper.value = 0.1
        view.addSubview(stepper)

        stepper.rx.value.asObservable()
        .subscribe(onNext: {
            print("当前值为：\($0)")
        })
        .disposed(by: disposeBag)

        slider.rx.value.asObservable()
            .map{ Double($0 * 0.1)}  //由于slider值为Float类型，而stepper的stepValue为Double类型，因此需要转换
            .bind(to: stepper.rx.stepValue)
            .disposed(by: disposeBag)
        
    }


}
