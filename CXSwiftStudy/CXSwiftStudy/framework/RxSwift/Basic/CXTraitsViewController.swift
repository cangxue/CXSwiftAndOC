//
//  CXTraitsViewController.swift
//  CXSwiftStudy
//
//  Created by ymh on 2018/3/13.
//  Copyright © 2018年 CX. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

//与数据相关的错误类型
private enum TraitError: Error {
    case cantParseJson
    case error
}


class CXTraitsViewController: CXBaseViewController {

    let disposeBag = DisposeBag()
    
    var label: UILabel!
    
    var textField: UITextField!
    
    var button = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label = UILabel(frame: CGRect(x: 50, y: 80, width: view.frame.size.width - 100, height: 30))
        label.backgroundColor = UIColor.yellow
        self.view.addSubview(label)
        label.text = "测试数据"
        
        textField = UITextField(frame: CGRect(x: 50, y: 130, width: view.frame.size.width - 100, height: 30))
        textField.backgroundColor = UIColor.orange
        self.view.addSubview(textField)
        textField.placeholder = "测试数据"
        
        button = UIButton(type: .system)
        button.frame = CGRect(x: 50, y: 180, width: view.frame.size.width - 100, height: 30)
        button.setTitle("点击一下", for: .normal)
        self.view.addSubview(button)
        
        
        self.schedulers()
    }
    
    //MARK: --- single ---
    func trait_single() {
        //获取第0个频道的信息
        getPlayList("0")
            .subscribe(onSuccess: { (json) in
                print("JSON数据：", json)
            }) { (error) in
                print("发生错误：", error)
            }
            .disposed(by: disposeBag)
        
        Observable.of("1")
            .asSingle()
            .subscribe({ print($0) })
            .disposed(by: disposeBag)
    }
    //获取豆瓣歌曲
    func getPlayList(_ channel: String) -> Single<[String: Any]> {
        return Single<[String: Any]>.create(subscribe: { (single) -> Disposable in
            let url = "https://douban.fm/j/mine/playlist?"
                + "type=n&channel=\(channel)&from=mainsite"
            let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { (data, _, error) in
                if let error = error {
                    single(.error(error))
                    return
                }
                
                guard let data = data,
                    let json = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves),
                    let result = json as? [String: Any] else {
                        single(.error(TraitError.cantParseJson))
                        return
                }
                
                single(.success(result))
                
            })
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
            
        })
    }
    
    //MARK: --- Completable ---
    func trait_completable() {
        cacheLocally()
            .subscribe(onCompleted: {
                print("保存成功")
            }) { (error) in
                print("保存失败: \(error.localizedDescription)")
            }
            .disposed(by: disposeBag)
    }
    //将数据缓存到本地
    func cacheLocally() -> Completable {
        return Completable.create(subscribe: { (completable) -> Disposable in
            //将数据缓存到本地
            let success = (arc4random() % 2 == 0)
            
            guard success else {
                completable(.error(TraitError.error))
                return Disposables.create()
            }
            
            completable(.completed)
            return Disposables.create()
            
        })
    }
    
    //MARK: --- Maybe ---
    func trait_maybe() {
        generateString()
            .subscribe(onSuccess: { (element) in
                print("执行完毕，并获得元素：\(element)")
            }, onError: { (error) in
                print("执行失败: \(error.localizedDescription)")
            }) {
                print("执行完毕，且没有任何元素。")
            }
            .disposed(by: disposeBag)
        
        Observable.of("1")
            .asMaybe()
            .subscribe({ print($0) })
            .disposed(by: disposeBag)
    }
    //生成字符串
    func generateString() -> Maybe<String> {
        return Maybe<String>.create(subscribe: { (maybe) -> Disposable in
            
            //将数据缓存到本地
            let success = (arc4random() % 2 == 0)
            
            guard success else {
                //失败
                maybe(.error(TraitError.error))
                return Disposables.create()
            }
            
            //成功
            maybe(.success("成功"))
            //完成
            maybe(.completed)
            
            
            
            return Disposables.create()
        })
    }
    
    //MARK: --- Driver ---
    func trait_driver() {
        
        textField.rx.text.asDriver()
            .drive(label.rx.text)
            .disposed(by: disposeBag)
    }
    
    //MARK: --- ControlProperty ---
    func control_property() {
        
        textField.rx.text
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }
    
    //MARK: --- ControlEvent ---
    func control_event() {
        
        button.rx.tap
            .subscribe(onNext: {
                self.label.text = "点击完成" + self.label.text!
            })
            .disposed(by: disposeBag)
    }
    
    //MARK: --- Schedulers ---
    func schedulers() {
        
        Observable.of("AAAAA")
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] item in
                self?.label.text = item
            })
            .disposed(by: disposeBag)
        
    }
}
