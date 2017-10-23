//
//  CXRuntimeViewController.m
//  CXOCStudy
//
//  Created by xiaoma on 2017/9/1.
//  Copyright © 2017年 CX. All rights reserved.
//

#import "CXRuntimeViewController.h"
#import "CXClass.h"
#import <objc/runtime.h>
#import "CXPerson.h"
#import <objc/message.h>

@interface CXRuntimeViewController ()

@end

@implementation CXRuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self cx_classMethod];
}

#pragma mark - 发送消息，调用私有方法
- (void)privateMethod {
    //初始化person
    CXPerson *person = objc_msgSend(objc_getClass("CXPerson"), sel_registerName("alloc"));
    person = objc_msgSend(person, sel_registerName("init"));
    
    //调用方法：必须先定义原型才可以使用
    //无参数无返回值
    objc_msgSend(person, @selector(printMessage1));
    ((void(*)(id, SEL))objc_msgSend)(person, @selector(printMessage1));
    //带一参数但是没有返回值
    ((void(*)(id,SEL,NSString *))objc_msgSend)(person, @selector(printMessage2:), @"带一参数但是没有返回值");
    NSString *str = @"hello, world";
    ((void(*)(id,SEL,NSString *))objc_msgSend)(person, @selector(printMessage2:),str);
    //带返回值，但是不带参数的方法
    NSString *returnStr = ((NSString *(*)(id, SEL))objc_msgSend)((id)person, @selector(printMessage3));
    NSLog(@"%@",returnStr);
    
    //带返回值，带参数的方法
    NSString *returnStr1 = ((NSString *(*)(id, SEL, NSString *))objc_msgSend)(person, @selector(printMessage4:), @"带返回值，带参数的方法");
    NSLog(@"%@", returnStr1);
    
}

#pragma mark - 类与对象操作函数
- (void)cx_classMethod {
    CXClass *myClass = [[CXClass alloc] init];
    unsigned int outCount = 0;
    Class cls = myClass.class;
    
    // 类名
    NSLog(@"class name: %s", class_getName(cls));
    NSLog(@"==========================================================");
    
    // 父类
    NSLog(@"super class name: %s", class_getName(class_getSuperclass(cls)));
    NSLog(@"==========================================================");
    
    // 是否是元类
    NSLog(@"MyClass is %@ a meta-class", (class_isMetaClass(cls) ? @"" : @"not"));
    NSLog(@"==========================================================");
    
    Class meta_class = objc_getMetaClass(class_getName(cls));
    NSLog(@"%s is meta-class is %s", class_getName(cls), class_getName(meta_class));
    NSLog(@"==========================================================");
    
    // 实例变量大小
    NSLog(@"instance size: %zu", class_getInstanceSize(cls));
    NSLog(@"==========================================================");
    
    // 成员变量
    Ivar *ivars = class_copyIvarList(cls, &outCount);
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = ivars[i];
        NSLog(@"instance variable is name: %s at index: %d", ivar_getName(ivar), i);
    }
    free(ivars);
    
    Ivar string = class_getInstanceVariable(cls, "_string");
    if (string != NULL) {
        NSLog(@"instance variable %s", ivar_getName(string));
    }
    
    NSLog(@"==========================================================");
    
    // 属性操作
    objc_property_t *properties = class_copyPropertyList(cls, &outCount);
    
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSLog(@"property's name: %s", property_getName(property));
    }
    free(properties);
    
    objc_property_t array = class_getProperty(cls, "array");
    if (array != NULL) {
        NSLog(@"property %s", property_getName(array));
    }
    
    NSLog(@"==========================================================");
    
    // 方法操作
    Method *methods = class_copyMethodList(cls, &outCount);
    for (int i = 0; i < outCount; i++) {
        Method method = methods[i];
        NSLog(@"method's signature: %s", method_getName(method));
    }
    free(methods);
    
    Method method1 = class_getInstanceMethod(cls, @selector(method1));
    if (method1 != NULL) {
        NSLog(@"method %s", method_getName(method1));
    }
    
    Method classMethod = class_getClassMethod(cls, @selector(classMethod1));
    if (classMethod != NULL) {
        NSLog(@"class method: %s", method_getName(classMethod));
    }
    
    NSLog(@"CXClass is %@ responds to selector: method3WithArt1:arg2: ",class_respondsToSelector(cls, @selector(method3WithArg1:arg2:)) ? @"" : @"not");
    
    IMP imp = class_getMethodImplementation(cls, @selector(method1));
//    imp();
    
    NSLog(@"==========================================================");
    
    // 协议
    Protocol *__unsafe_unretained *protocols = class_copyProtocolList(cls, &outCount);
    Protocol *protocol;
    for (int i = 0; i < outCount; i++) {
        protocol = protocols[i];
        NSLog(@"protocol name: %s", protocol_getName(protocol));
    }
    
    NSLog(@"MyClass is%@ responsed to protocol %s", class_conformsToProtocol(cls, protocol) ? @"" : @" not", protocol_getName(protocol));
    NSLog(@"==========================================================");
}

#pragma mark - 动态创建类和对象
- (void)addClassMethod {
    /******* 动态创建类 ********/
    Class cls = objc_allocateClassPair(CXClass.class, "MySubClass", 0);
    
//    class_addMethod(cls, @selector(submethod1), (IMP)imp_submethod1, "v@:");
//    class_replaceMethod(cls, @selector(method1), (IMP)imp_submethod1, "v@:");
    class_addIvar(cls, "_ivar1", sizeof(NSString *), log(sizeof(NSString *)), "i");
    objc_property_attribute_t type = {"T", "@\"NSString\""};
    objc_property_attribute_t ownership = { "C", "" };
    objc_property_attribute_t backingivar = { "V", "_ivar1"};
    objc_property_attribute_t attrs[] = {type, ownership, backingivar};
    class_addProperty(cls, "property2", attrs, 3);
    objc_registerClassPair(cls);
    
    id instance = [[cls alloc] init];
    [instance performSelector:@selector(submethod1)];
    [instance performSelector:@selector(method1)];
    
    
    /******* 动态创建对象 ********/
    id theObject = class_createInstance(NSString.class, sizeof(unsigned));
//    id theObject = class_cre
    
    id str1 = [theObject init];
    NSLog(@"%@", [str1 class]);
    id str2 = [[NSString alloc] initWithString:@"test"];
    NSLog(@"%@", [str2 class]);
    
    /******* 实例操作函数 ********/
//    NSObject *a = [[NSObject alloc] init];
//    id newB = object_copy(a, class_getInstanceSize(CXClass.class));
//    object_setClass(newB, CXClass.class);
//    object_dispose(a);
//    
//    int numClasses;
//    Class * classes = NULL;
//    numClasses = objc_getClassList(NULL, 0);
//    if (numClasses > 0) {
//        classes = malloc(sizeof(Class) * numClasses);
//        numClasses = objc_getClassList(classes, numClasses);
//        NSLog(@"number of classes: %d", numClasses);
//        for (int i = 0; i < numClasses; i++) {
//            Class cls = classes[i];
//            NSLog(@"class name: %s", class_getName(cls));
//        }
//        free(classes);
//    }
}

- (void)submethod1 {
    
}

@end
