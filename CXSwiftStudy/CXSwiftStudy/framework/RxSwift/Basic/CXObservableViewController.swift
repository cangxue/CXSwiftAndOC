//
//  CXObservableViewController.swift
//  CXSwiftStudy
//
//  Created by ymh on 2018/3/10.
//  Copyright © 2018年 CX. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


enum MyError: Error {
    case A
    case B
}

class CXObservableViewController: CXBaseViewController {
    
    let disposeBag = DisposeBag()
    
    var label: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        label = UILabel(frame: CGRect(x: 50, y: 80, width: view.frame.size.width - 100, height: 30))
        self.view.addSubview(label)
        label.text = "测试数据"
    
        self.debug_operators()
        
    }
    
    // MARK: --- 创建 Observable 序列 ---
    func create_observable() {
        var observable = Observable<Int>.just(5)
        
        observable = Observable.of(1, 2, 3)
        
        observable = Observable.from([1, 2, 3])
        
        observable = Observable<Int>.empty()
        
        observable = Observable<Int>.never()
        
        observable = Observable<Int>.error(MyError.A)
        
        observable = Observable.range(start: 1, count: 5)
        
        observable = Observable.repeatElement(1)
        
        observable = Observable.generate(
            initialState: 0,
            condition: { $0 <= 10 },
            iterate: {$0 + 2}
        )
        
        observable = Observable<Int>.create({ observer in
            observer.onNext(5)
            observer.onCompleted()
            return Disposables.create()
        })
        
        var isOdd = true
        
        observable = Observable.deferred {
            isOdd = !isOdd
            
            if isOdd {
                return Observable.of(1, 3, 5, 7)
            } else {
                return Observable.of(2, 4, 6, 8)
            }
        }
        
        observable = Observable.deferred({ () -> Observable<Int> in
            return Observable.of(22, 44, 66, 88)
        })
        
        let observable1 = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        
        //5秒种后发出唯一的一个元素0
        let observable2 = Observable<Int>.timer(5, scheduler: MainScheduler.instance)
        
        //延时5秒种后，每隔1秒钟发出一个元素
        let observable13 = Observable<Int>.timer(1, period: 1, scheduler: MainScheduler.instance)
        
        observable1.subscribe { event in
            print(event)
        }
        
        observable.subscribe(onNext: { (element) in
            print(element)
        }).dispose()
    }
    
    //MARK: --- 订阅 Observable ---
    func subcribe_observable() {
        let observable = Observable.of("A", "B", "C")
        observable
            .do(onNext: { element in
                print("Intercepted Next: ", element)
            }, onError: { error in
                print("Intercepted Error: ", error)
            })
            .subscribe(onNext: { element in
                print(element)
            })
        
        
        observable.subscribe { (event) in
            print("\(event) : \(event.element)")
        }
        
        observable.subscribe(onNext: { (element) in
            print(element)
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("completed")
        }) {
            print("disposed")
        }
        
        observable.subscribe(onNext: { element in
            print(element)
        })
        
        //使用subscription常量存储这个订阅方法
        let subscription = observable.subscribe({ event in
            print(event)
        })
        //调用这个订阅的dispose()方法
        subscription.dispose()
        
        let disposedBag = DisposeBag()
        let observable1 = Observable.of("AA", "BB", "CC")
        observable1
            .subscribe({ event in
            print(event)
            })
            .disposed(by: disposedBag)
        
        observable
            .map({"当前索引数：\($0)"})
            .bind { text in
                print(text)
            }
            .disposed(by: disposedBag)
    }
    
    //MARK: --- 观察者(Observer)方法 ---
    func observerMethod() {
        let observable = Observable.of("AA", "BB", "CC")
        
        /// --- 直接在 subscribe、bind 方法中创建观察者 ---
        //在 subscribe 方法中创建
        observable
            .subscribe({ event in
                print(event)
            })
            .disposed(by: disposeBag)
        
        //在 bind 方法中创建
        observable
            .map({"当前索引数：\($0)"})
            .bind { text in
                print(text)
            }
            .disposed(by: disposeBag)
        
        /// --- 使用 AnyObserver 创建观察者 ---
        //使用 AnyObserver 创建观察者
        let observer: AnyObserver<String> = AnyObserver { event in
            switch event {
            case .next(let data):
                print(data)
            case .error(let error):
                print(error)
            case .completed:
                print("completed")
            }
        }
        
        //配合 subscribe 方法使用
        observable.subscribe(observer).dispose()
        
        //配合 bindTo 方法使用
        observable
            .map({"这是: \($0)"})
            .bind(to: observer)
            .disposed(by: disposeBag)
        
        /// --- 使用 Binder 创建观察者 ---
        //观察者
        let observer1: Binder<String> = Binder(label) { (view, text) in
            view.text = text
        }
        
        //observable
        let observable1 = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        observable1
        .map({"当前索引数：\($0)"})
        .bind(to: observer1)
        .disposed(by: disposeBag)
        
        
        let observer2: Binder<String> = Binder(self) { (self, text) in
            print(text)
        }
        observable.subscribe(observer2).dispose()
        
    }
    
    //MARK: --- 自定义可绑定属性 ---
    func extensionMethod() {
        let observable = Observable<Int>.interval(0.5, scheduler: MainScheduler.instance)
        observable.map{ CGFloat($0) }
        .bind(to: label.rx.fontSize)
        .disposed(by: disposeBag)
        
        let observable1 = Observable.just("AAAAA")
        observable1.map({$0})
        .bind(to: label.rx.text )
        .disposed(by: disposeBag)
        
    }
    
    //MARK: --- Subjects介绍 ---
    func subjectsMethod() {
        
        /*********** PublishSubject ***********/
        //创建一个PublishSubject
        let subject = PublishSubject<String>()
        //第一次订阅
        subject.subscribe(onNext: { (string) in
            print("第一次订阅: ", string)
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("第一次订阅：onCompleted")
        }).disposed(by: disposeBag)
        //当前有订阅，则会输出到控制台
        subject.onNext("111")
    
        //第二次订阅
        subject.subscribe(onNext: { (string) in
            print("第二次订阅: ", string)
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("第二次订阅：onCompleted")
        }).disposed(by: disposeBag)
        //当前有订阅，则会输出到控制台
        subject.onNext("222")
        
        //让subject结束
        subject.onCompleted()
        
        
        /*********** BehaviorSubject ***********/
        //创建一个BehaviorSubject
        let subject2 = BehaviorSubject(value: "111")
        //第一次订阅
        subject2.subscribe({ event in
            print("第一次订阅:", event)
        }).disposed(by: disposeBag)
        //发送next事件
        subject2.onNext("222")
        
        //第二次订阅
        subject2.subscribe({ event in
            print("第二次订阅：", event)
        }).disposed(by: disposeBag)
        
        //让subject结束
        subject2.onCompleted()
        
        
        /*********** ReplaySubject ***********/
        //创建subject
        let subject3 = ReplaySubject<String>.create(bufferSize: 2)
        //发送事件
        subject3.onNext("1")
        subject3.onNext("2")
        subject3.onNext("3")
        
        //第一次订阅
        subject3.subscribe({ event in
            print("第一次订阅：", event)
        }).disposed(by: disposeBag)
        
        //再发送一个事件
        subject3.onNext("4")
        
        //第二次订阅
        subject3.subscribe({ event in
            print("第二次订阅：", event)
        }).disposed(by: disposeBag)
        
        //结束
        subject3.onCompleted()
        
        //第3次订阅subject
        subject3.subscribe { event in
            print("第三次订阅：", event)
        }.disposed(by: disposeBag)
        
        
        /*********** VariableSubject ***********/
        //创建
        let variable = Variable("111")
        
        //修改value值
        variable.value = "222"
        
        //第一次订阅
        variable.asObservable().subscribe({
            print("第一次订阅：", $0)
        }).disposed(by: disposeBag)
        
        //修改value值
        variable.value = "333"
        
        //第二次订阅
        variable.asObservable().subscribe({
            print("第二次订阅：", $0)
        }).disposed(by: disposeBag)
        
        //修改value值
        variable.value = "444"
        
    }
    
    //MARK: --- 变换操作 ---
    func transforming_observables() {
        let subject = PublishSubject<String>()
        
        //buffer
        subject
            .buffer(timeSpan: 1, count: 3, scheduler: MainScheduler.instance)
            .subscribe(onNext: { print("buffer: \($0)") })
            .disposed(by: disposeBag)
        
        //window
        subject
            .window(timeSpan: 1, count: 3, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                print("window: \($0)")
                $0.asObservable()
                    .subscribe(onNext: { print("window1: \($0)") })
                    .disposed(by: (self?.disposeBag)!)
            })
            .disposed(by: disposeBag)
        
        //发送事件
        subject.onNext("a")
        subject.onNext("b")
        subject.onNext("c")
        
        subject.onNext("1")
        subject.onNext("2")
        subject.onNext("3")
        
        subject.onCompleted()
        
        //map
        Observable.of(1, 2, 3)
            .map({ $0 * 10 })
            .subscribe(onNext: { print("map: \($0)") })
            .disposed(by: disposeBag)
        
        //flatMap/flatMapLatest/concatMap
        let subject1 = BehaviorSubject(value: "A")
        let subject2 = BehaviorSubject(value: "1")
        
        let variable = Variable(subject1)
        
        variable.asObservable()
            .concatMap({ $0 })
            .subscribe(onNext: { print("flatMap: \($0)") })
            .disposed(by: disposeBag)
        
        subject1.onNext("B")
        variable.value = subject2
        subject2.onNext("2")
        subject1.onNext("C")
        
        //concatMap使用
        subject1.onCompleted() //只有前一个序列结束后，才能接收下一个序列
        
        //scan
        Observable.of(1, 2, 3, 4, 5)
            .scan(0) { acum, elem in
                acum + elem
            }
            .subscribe(onNext: { print("scan: \($0)") })
            .disposed(by: disposeBag)
        
        //groupBy
        //将奇数和偶数分成两组
        Observable<Int>.of(1, 2, 3, 4, 5, 6)
            .groupBy { (element) -> String in
                return element % 2 == 0 ? "偶数" : "奇数"
            }
            .subscribe({ (event) in
                switch event {
                case .next(let group):
                    group.asObservable().subscribe({ (event) in
                        print("key: \(group.key) event: \(event)")
                    })
                        .disposed(by: self.disposeBag)
                case .error(_):
                    print("error")
                case .completed:
                    print("oncompleted")
                }
            })
            .disposed(by: disposeBag)
        
    }
    
    //MARK: --- 过滤操作符（Filtering Observables）
    func filtering_observable() {
        //filter
        Observable.of(2, 30, 40, 50)
            .filter {
                $0 > 10
            }
            .subscribe(onNext: {
                print("filter: \($0)")
            })
            .disposed(by: disposeBag)
        
        //distinctUntilChanged
        Observable.of(1, 1, 2, 3, 3)
            .distinctUntilChanged()
            .subscribe(onNext: {
                print("distinctUntilChanged: \($0)")
            })
            .disposed(by: disposeBag)
        
        //single
        Observable.of(1, 2, 3, 4)
            .single { (input) -> Bool in
                input == 2
            }
            .subscribe(onNext: {
                print("single: \($0)")
            })
            .disposed(by: disposeBag)
        
        //elementAt
        Observable.of(1, 2, 3, 4)
            .elementAt(2)
            .subscribe(onNext: {print("elementAt: \($0)")} )
            .disposed(by: disposeBag)
        
        //ignoreElements
        Observable.of(1, 2, 3)
            .ignoreElements()
            .subscribe({ print("ignoreElement: \($0)") })
            .disposed(by: disposeBag)
        
        //take
        Observable.of(1, 2, 3, 4)
            .take(2)
            .subscribe({ print("take: \($0)") })
            .disposed(by: disposeBag)
        
        //takeLast
        Observable.of(1, 2, 3, 4)
            .takeLast(2)
            .subscribe({ print("takeLast: \($0)") })
            .disposed(by: disposeBag)
        
        //skip
        Observable.of(1, 2, 3, 4)
            .skip(2)
            .subscribe({ print("skip: \($0)") })
            .disposed(by: disposeBag)
        
        //sample
        let source = PublishSubject<Int>()
        let notifier = PublishSubject<String>()
        
        source
            .sample(notifier)
            .subscribe({ print("sample: \($0)") })
            .disposed(by: disposeBag)
        
        source.onNext(1)
        //让源序列接收消息
        notifier.onNext("A")
        
        source.onNext(2)
        notifier.onNext("B")
        notifier.onNext("C")
        
        source.onNext(3)
        source.onNext(4)
        
        //让源序列接收消息
        notifier.onNext("D")
        
        source.onNext(5)
        
        //让源序列接收消息
        notifier.onCompleted()
        
        
        //debounce
        //定义好每个事件里的值以及发送的时间
        let times = [
            [ "value": 1, "time": 0.1 ],
            [ "value": 2, "time": 1.1 ],
            [ "value": 3, "time": 1.2 ],
            [ "value": 4, "time": 1.2 ],
            [ "value": 5, "time": 1.4 ],
            [ "value": 6, "time": 2.1 ]
        ]
        
        //生成对应的 Observable 序列并订阅
        Observable.from(times)
            .flatMap({ item in
                return Observable.of(Int(item["value"]!))
                .delaySubscription(Double(item["time"]!),
                                   scheduler: MainScheduler.instance)
            })
            .debounce(0.5, scheduler: MainScheduler.instance) //只发出与下一个间隔超过0.5秒的元素
            .subscribe({ print("debounce: \($0)") })
            .disposed(by: disposeBag)
    }
    
    //MARK: -- 条件和布尔操作符（Conditional and Boolean Operators） ---
    func conditional_Operators() {
        //amb
        let subject1 = PublishSubject<Int>()
        let subject2 = PublishSubject<Int>()
        let subject3 = PublishSubject<Int>()
        
        subject1
            .amb(subject2)
            .amb(subject3)
            .subscribe(onNext: { print("amb: \($0)") })
            .disposed(by: disposeBag)
        
        subject1.onNext(1)
        subject2.onNext(2)
        subject3.onNext(3)
        subject1.onNext(11)
        subject2.onNext(22)
        subject3.onNext(33)
        
        //takeWhile
        Observable.of(2, 3, 4, 5, 6)
            .takeWhile({ $0 < 4 })
            .subscribe(onNext: { print("takeWhile: \($0)") })
            .disposed(by: disposeBag)
        
        //takeUntil
        let source = PublishSubject<String>()
        let notifier = PublishSubject<String>()
        source
            .takeUntil(notifier)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        source.onNext("a")
        source.onNext("b")
        //停止接收消息
        notifier.onNext("z")
        source.onNext("e")
        
        
        //skipWhile
        Observable.of(2, 3, 4, 5, 6)
            .skipWhile({ $0 < 4 })
            .subscribe(onNext: { print("skipWhile: \($0)") })
            .disposed(by: disposeBag)
        
        
        //skipUntil
        let source2 = PublishSubject<Int>()
        let notifier2 = PublishSubject<Int>()
        source2
            .skipUntil(notifier)
            .subscribe(onNext: { print("skipUntil: \($0)") })
            .disposed(by: disposeBag)
        source2.onNext(1)
        source2.onNext(2)
        //开始接收消息
        notifier2.onNext(0)
        source2.onNext(3)
        source2.onNext(4)
        //仍然接收消息
        notifier2.onNext(0)
        source2.onNext(5)
        
    }
    
    //MARK: -- 结合操作（Combining Observables）） ---
    func combining_observable() {
        //startWith
        Observable.of("2", "3")
            .startWith("1")
            .startWith("4")
            .subscribe(onNext: { print("startWith: \($0)") })
            .disposed(by: disposeBag)
        
        //merge
        let subject1 = PublishSubject<Int>()
        let subject2 = PublishSubject<Int>()
        Observable.of(subject1, subject2)
            .merge()
            .subscribe(onNext: { print("merge: \($0)") })
            .disposed(by: disposeBag)
        subject1.onNext(20)
        subject1.onNext(40)
        subject2.onNext(1)
        
        //zip
        let subject3 = PublishSubject<Int>()
        let subject4 = PublishSubject<String>()
        Observable.zip(subject1, subject3) {
            "\($0)-\($1)"
            }
            .subscribe(onNext: { print("zip: \($0)") })
            .disposed(by: disposeBag)
        subject3.onNext(1)
        subject4.onNext("A")
        subject3.onNext(2)
        subject4.onNext("B")
        subject3.onNext(1)
        
        //combineLatest
        let subject5 = PublishSubject<Int>()
        let subject6 = PublishSubject<String>()
        Observable.combineLatest(subject1, subject3) {
            "\($0)-\($1)"
            }
            .subscribe(onNext: { print("combineLatest: \($0)") })
            .disposed(by: disposeBag)
        
        subject5.onNext(1)
        subject6.onNext("A")
        subject5.onNext(2)
        subject6.onNext("B")
        subject5.onNext(1)
        
        //withLatesFrom
        let subject7 = PublishSubject<String>()
        let subject8 = PublishSubject<String>()
        subject7.withLatestFrom(subject8)
            .subscribe(onNext: { print("withLatesFrom: \($0)") })
            .disposed(by: disposeBag)
        subject7.onNext("A")
        subject8.onNext("1")
        subject7.onNext("B")
        subject7.onNext("C")
        subject8.onNext("2")
        subject7.onNext("D")
        
        //switchLatest
        let subject9 = BehaviorSubject(value: "A")
        let subject10 = BehaviorSubject(value: "1")
        let variable = Variable(subject9)
        variable.asObservable()
            .switchLatest()
            .subscribe(onNext: { print("switchLatest: \($0)") })
            .disposed(by: disposeBag)
        subject9.onNext("B")
        subject9.onNext("C")
        //改变事件源
        variable.value = subject10
        subject9.onNext("D")
        subject10.onNext("2")
    }
    
    //MARK: -- 算数、以及聚合操作（Mathematical and Aggregate Operators） ---
    func mathematical_observable() {
        //toArray
        Observable.of(1, 2, 3)
            .toArray()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        //reduce
        Observable.of(1, 2, 3, 4, 5)
            .reduce(0, accumulator: +)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        //concat
        let subject1 = BehaviorSubject(value: 1)
        let subject2 = BehaviorSubject(value: 2)
        
        let variable = Variable(subject1)
        variable.asObservable()
            .concat()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject2.onNext(2)
        subject1.onNext(1)
        subject1.onNext(1)
        subject1.onCompleted()
        variable.value = subject2
        subject2.onNext(2)
    }
    
    //MARK: -- 连接操作（Connectable Observable Operators） ---
    func connectable_observable() {
        //普通序列
//        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        
        //publish
//        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance).publish()
        
        //replay
//        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance).replay(2)
        
        //multicast
//        //创建一个Subject
//        let subject = PublishSubject<Int>()
//        //这个Subject的订阅
//        _ = subject
//            .subscribe(onNext: { print("Subject: \($0)") })
//        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance).multicast(subject)
        
        //refCount
//        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
//            .publish()
//            .refCount()
        
        //share
        let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance).share(replay: 2)
        
        //第一个订阅者（立刻开始订阅）
        _ = interval
            .subscribe(onNext: { print("订阅1: \($0)") })
        
        //可连接序列执行，不connect，所有订阅不会执行
//        _ = interval.connect()
        
        //第二个订阅者（延迟5s开始订阅）
        delay(5) {
            _ = interval
                .subscribe(onNext: { print("订阅222: \($0)") })
        }
        
    }
    
    //MARK: -- 其他一些实用的操作符（Observable Utility Operators） ---
    func other_operators() {
        //delay
        Observable.of(1, 2, 1)
            .delay(3, scheduler: MainScheduler.instance)
            .subscribe(onNext: {print("delay: \($0)")})
            .disposed(by: disposeBag)
        
        //delaySubscription
        Observable.of(3, 2, 1)
            .delaySubscription(3, scheduler: MainScheduler.instance)
            .subscribe(onNext: { print("delaySubcription: \($0)") })
            .disposed(by: disposeBag)
        
        //materialize
        Observable.of(4, 5, 6)
            .materialize()
            .subscribe(onNext: { print("materialize: \($0)") })
            .disposed(by: disposeBag)
        
        //dematerialize
        Observable.of(4, 5, 6)
            .materialize()
            .dematerialize()
            .subscribe(onNext: { print("materialize: \($0)") })
            .disposed(by: disposeBag)
        
        //timeout
        //定义好每个事件里的值以及发送的时间
        let times = [
            [ "value": 1, "time": 0 ],
            [ "value": 2, "time": 0.5 ],
            [ "value": 3, "time": 1.5 ],
            [ "value": 4, "time": 4 ],
            [ "value": 5, "time": 5 ]
        ]
        //生成对应的 Observable 序列并订阅
        Observable.from(times)
            .flatMap { item in
                return Observable.of(Int(item["value"]!))
                    .delaySubscription(Double(item["time"]!),
                                       scheduler: MainScheduler.instance)
            }
            .timeout(2, scheduler: MainScheduler.instance) //超过两秒没发出元素，则产生error事件
            .subscribe(onNext: { element in
                print(element)
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
        
        //using
        //一个无限序列（每隔0.1秒创建一个序列数 ）
        let infiniteInterval = Observable<Int>
            .interval(0.1, scheduler: MainScheduler.instance)
            .do(
                onNext: { print("infinite: \($0)") },
                onSubscribe: { print("开始订阅 infinite")},
                onDispose: { print("销毁 infinite")}
        )
        
        //一个有限序列（每隔0.5秒创建一个序列数，共创建三个 ）
        let limited = Observable<Int>
            .interval(0.5, scheduler: MainScheduler.instance)
            .take(2)
            .do(
                onNext: { print("limited: \($0)") },
                onSubscribe: { print("开始订阅 limited")},
                onDispose: { print("销毁 limited")}
        )
        
        //使用using操作符创建序列
        let o: Observable<Int> = Observable.using({ () -> AnyDisposable in
            return AnyDisposable(infiniteInterval.subscribe())
        }, observableFactory: { _ in
            return limited
            
        })
        o.subscribe().disposed(by: disposeBag)
        
    }
    
    //MARK: -- 错误处理操作（Error Handling Operators） ---
    func error_operators() {
        
        //catchErrorJusReturn
        let sequenceThatFails = PublishSubject<String>()
        sequenceThatFails
            .catchErrorJustReturn("错误")
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        sequenceThatFails.onNext("a")
        sequenceThatFails.onError(MyError.A)
        sequenceThatFails.onNext("b")
        
        //catchError
        let recoverySequence = Observable.of("1", "2", "3")
        sequenceThatFails
            .catchError { (error) -> Observable<String> in
                print("Error: \(error)")
                return recoverySequence
            }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        //retry
        var count = 1
        
        let sequenceThatErrors = Observable<String>.create { observer in
            observer.onNext("a")
            observer.onNext("b")
            
            //让第一个订阅时发生错误
            if count == 1 {
                observer.onError(MyError.A)
                print("Error encountered")
                count += 1
            }
            
            observer.onNext("c")
            observer.onNext("d")
            observer.onCompleted()
            
            return Disposables.create()
        }
        
        sequenceThatErrors
            .retry(2)  //重试2次（参数为空则只重试一次）
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
    }
    
    //MARK: -- 调试操作） ---
    func debug_operators() {
        //debug
        Observable.of("2", "3")
            .startWith("1")
            .debug()
            .subscribe(onNext: {print($0)})
            .disposed(by: disposeBag)
        
        //RxSwift.Resources.total
    }
    
    
    
    ///延迟执行
    /// - Parameters:
    ///   - delay: 延迟时间（秒）
    ///   - closure: 延迟执行的闭包
    public func delay(_ delay: Double, closure: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            closure()
        }
    }
    
}

class AnyDisposable: Disposable {
    let _dispose: () -> Void
    
    init(_ disposable: Disposable) {
        _dispose = disposable.dispose
    }
    
    func dispose() {
        _dispose()
    }
}

//通过对 UI 类进行扩展
extension UILabel {
    public var fontSize: Binder<CGFloat> {

        return Binder(self) { label, fontSize in
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}

//通过对 Reactive 类进行扩展
extension Reactive where Base: UILabel {
    public var fontSize: Binder<CGFloat> {
        return Binder(self.base) { label, fontSize in
            label.font = UIFont.systemFont(ofSize: fontSize)
            
        }
    }
    
    public var text: Binder<String?> {
        return Binder(self.base) { label, text in
            label.text = text
        }
    }
}


