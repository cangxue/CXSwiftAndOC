//
//  CXHeader.h
//  CXOCStudy
//
//  Created by xiaoma on 2017/7/27.
//  Copyright © 2017年 CX. All rights reserved.
//

#ifndef CXHeader_h
#define CXHeader_h

/* 基础设置 */

//设置颜色值
#define kColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

#define kColoralpha(r,g,b,a)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define UIColorFromRGB(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000)>>16))/255.0 green:((float)((rgbValue & 0xFF00)>>8))/255.0  blue:((float)((rgbValue & 0xFF)))/255.0  alpha:a]

//全局共用的颜色
#define NavtionBarColor    kColoralpha(165,38,39,1)

#define MAIN_COLOR         kColoralpha(165,38,39,1)

#define COMMON_TITLE_COLOR    kColoralpha(139,153,168,1)

#define BANNER_TITLE_COLOR   kColoralpha(51,51,51,1)

#define contenColor kColor(153, 153, 153)
#define lineColor kColor(246, 246, 246)
#define titleNormolColor kColor(147, 143, 143)
#define BlackColor kColor(36, 37, 44)


//屏幕宽高
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height







/*   weakSelf/strongSelf宏定义   */

//YYKit中的
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif


//传统写法
//#ifndef    weakify
//#if __has_feature(objc_arc)
//
//#define weakify( x ) \
//_Pragma("clang diagnostic push") \
//_Pragma("clang diagnostic ignored \"-Wshadow\"") \
//autoreleasepool{} __weak __typeof__(x) __weak_##x##__ = x; \
//_Pragma("clang diagnostic pop")
//
//#else
//
//#define weakify( x ) \
//_Pragma("clang diagnostic push") \
//_Pragma("clang diagnostic ignored \"-Wshadow\"") \
//autoreleasepool{} __block __typeof__(x) __block_##x##__ = x; \
//_Pragma("clang diagnostic pop")
//
//#endif
//#endif
//
//#ifndef    strongify
//#if __has_feature(objc_arc)
//
//#define strongify( x ) \
//_Pragma("clang diagnostic push") \
//_Pragma("clang diagnostic ignored \"-Wshadow\"") \
//try{} @finally{} __typeof__(x) x = __weak_##x##__; \
//_Pragma("clang diagnostic pop")
//
//#else
//
//#define strongify( x ) \
//_Pragma("clang diagnostic push") \
//_Pragma("clang diagnostic ignored \"-Wshadow\"") \
//try{} @finally{} __typeof__(x) x = __block_##x##__; \
//_Pragma("clang diagnostic pop")
//
//#endif
//#endif




#endif



