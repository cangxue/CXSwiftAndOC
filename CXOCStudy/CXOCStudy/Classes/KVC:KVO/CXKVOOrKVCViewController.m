//
//  CXKVOOrKVCViewController.m
//  CXOCStudy
//
//  Created by xiaoma on 2017/8/4.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "CXKVOOrKVCViewController.h"

#import "CXPerson.h"
#import "CXAccount.h"

@interface CXKVOOrKVCViewController ()

@property (nonatomic, strong) CXPerson *mainPerson;

@end

@implementation CXKVOOrKVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self kvcMethod];

    [self addObserverMethod];
}

#pragma mark - KVC:键值编码

- (void)kvcMethod {
    CXPerson *person1 = [[CXPerson alloc] init];
    
    /** 动态设置属性
     1、优先考虑调用setA方法
     2、考虑搜索成员变量_a
     3、搜索成员变量a
     5、搜索成员变量isA
     6、调用这个类的setValue:forUndefinedKey：方法
     
     
     备注：
     1、如果它的参数类型不是一个对象指针类型,但是值为nil,就会执行setNilValueForKey:方法,setNilValueForKey:方法的默认实现,是产生一个NSInvalidArgumentException的异常
     2、上面的setter方法没有找到，如果类方法accessInstanceVariablesDirectly返回YES(注：这是NSKeyValueCodingCatogery中实现的类方法，默认实现为返回YES)。那么按_<key>，_is<Key>，<key>，is<key>的顺序搜索成员名。则执行forUndefinedKey方法
     3、如果方法的参数类型是NSNumber或NSValue的对应的基本类型,先把它转换为基本数据类,再执行方法,传入转换后的数据.
     4、如果访问器方法和实例变量都没有找到,执行setValue:forUndefinedKey:方法,该方法的默认实现是产生一个 NSUndefinedKeyException 类型的异常,但是我们可以重写setValue:forUndefinedKey:方法
     
     */
    
    //给成员变量name设置值，优先调用setName方法
    [person1 setValue:@"Cangxue" forKey:@"name"];
    //KVC也可以用于私有变量，且没有setAge方法，有_age则能设置值
    [person1 setValue:@26 forKey:@"age"];
    //且没有setSex方法，有isSex则能设置值
    [person1 setValue:@"男" forKey:@"sex"];
    //且没有setDate方法，有_isDate则能设置值
    [person1 setValue:@"2000 - 12 - 12" forKey:@"date"];
    //没有setSchool,没有_school,有school
    [person1 setValue:@"qinghua" forKey:@"school"];
    //没有agee则调用setValue:forUndefinedKey：
    [person1 setValue:@26 forKey:@"agee"];
    
    [person1 setValue:@"12345678912" forKey:@"tel"];
    
    
    //设置nil值
    [person1 setValue:nil forKey:@"nilValueKey"];
    
    [person1 showMessage];
    
    
    CXAccount *account1 = [[CXAccount alloc] init];
    person1.account = account1;
    //通过forKeyPath路径设置值
    [person1 setValue:@666 forKeyPath:@"account.balance"];
    
    
    /** 动态读取属性
     1、优先考虑调用a方法（属性a的getter方法）
     2、考虑搜索成员变量_a
     3、搜索成员变量a
     4、调用这个类的valueforUndefinedKey：方法
     */
    
    //优先调用tel方法
    NSString *telStr = [person1 valueForKey:@"tel"];
    //获取name的值
    NSString *nameStr = [person1 valueForKey:@"name"];
    //调用_age
    NSString *ageStr = [person1 valueForKey:@"age"];
    //调用isSex
    NSString *sexStr = [person1 valueForKey:@"sex"];
    //没有namee
    NSString *noKeyStr = [person1 valueForKey:@"namee"];
    //keypath获取值
    NSString *keyPathStr = [person1 valueForKeyPath:@"account.balance"];
    
    NSLog(@"\n person1 name = %@,\n sex = %@,\n age= %d,\n balance = %.2f,\n tel = %@",nameStr,sexStr, [ageStr intValue], [keyPathStr floatValue], telStr);
    
    NSLog(@"%@",noKeyStr);
}

#pragma makr - KVO键值观察
- (void)addObserverMethod {
    
    
    _mainPerson = [[CXPerson alloc] init];
    _mainPerson.name = @"cangxue";
    NSLog(@"%@",_mainPerson.name);
    
    /**调用方法是里:
     
     　　object : 被观察对象
     
     　　observer: 观察对象
     
     　　forKeyPath里面带上property的name，如UIView的frame、center等等
     
     　　options: 有4个值，分别是：
     
     　　NSKeyValueObservingOptionNew 把更改之前的值提供给处理方法
     
     　　NSKeyValueObservingOptionOld 把更改之后的值提供给处理方法
     
     　　NSKeyValueObservingOptionInitial 把初始化的值提供给处理方法，一旦注册，立马就会调用一次。通常它会带有新值，而不会带有旧值。
     
     　　NSKeyValueObservingOptionPrior 分2次调用。在值改变之前和值改变之后。
     
     　　context: 可以带入一些参数，其实这个挺好用的，任何类型都可以，自己强转就好了。
     */
    
    [_mainPerson addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionPrior context:@"这是改变名字的"];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self kvoMethod];
    });
    
}

//添加监听
- (void)kvoMethod {
    _mainPerson.name = @"new cangxue";
}

//重写observerValueForKeyPath方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    /**处理方法里：
     
     　　keyPath: 对应forKeyPath
     
     　　object:  被观察的对象
     
     　　change:  对应options里的NSKeyValueObservingOptionNew、NSKeyValueObservingOptionOld等
     
     　　context： 对应context
     */
    
    if ([keyPath isEqualToString:@"name"]) {
        NSString *newStr = [change objectForKey:@"new"];
        NSLog(@"我的%@变为%@",keyPath, newStr);
        NSLog(@"%@",context);
    }
}

//销毁
- (void)dealloc {
    [_mainPerson removeObserver:self forKeyPath:@"name"];
}

@end
