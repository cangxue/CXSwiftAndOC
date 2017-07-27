//
//  CXHeader.h
//  CXOCStudy
//
//  Created by xiaoma on 2017/7/27.
//  Copyright © 2017年 CX. All rights reserved.
//

#ifndef CXHeader_h
#define CXHeader_h


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




#endif /* CXHeader_h */
