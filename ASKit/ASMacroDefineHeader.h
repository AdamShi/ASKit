//
//  ASMacroDefineHeader.h
//  ASKit
//
//  Created by AdamShi on 2018/5/22.
//  Copyright © 2018年 AdamShi. All rights reserved.
//

#ifndef ASMacroDefineHeader_h
#define ASMacroDefineHeader_h

//色值简写
#define COLOR(r,g,b)        [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define COLORA(r,g,b,a)     [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define ColorFromRGB(rgb)   [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define ClearColor          [UIColor clearColor]
#define WhiteColor          [UIColor whiteColor]
#define BlackColor          [UIColor blackColor]
#define GrayColor           [UIColor grayColor]
#define RedColor            [UIColor redColor]
#define YellowColor         [UIColor yellowColor]
#define BlueColor           [UIColor blueColor]
#define GreenColor          [UIColor greenColor]
#define OrangeColor         [UIColor orangeColor]

//本地图标赋值简写
#define IMAGE(name)         [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",name]]

//获得手机系统版本
#define SYSTEM_VERSION [[UIDevice currentDevice].systemVersion floatValue]

//系统API简写
#define ASKeyWindow [UIApplication sharedApplication].keyWindow

//*************iPhoneX及ios11相关宏****************
//为了兼容模拟器,使用屏幕大小判断是否iPhoneX
#define IS_IPHONEX (CGSizeEqualToSize([[UIScreen mainScreen] bounds].size, CGSizeMake(375, 812)))
//根据系统版本约束subView到superView的bottom的offset
#define MASSafeBottomToSuperViewWithOffset(superView, kOffset) \
if (@available(iOS 11.0, *)) { \
make.bottom.mas_equalTo(superView.mas_safeAreaLayoutGuide).offset(kOffset); \
} else { \
make.bottom.mas_equalTo(superView).offset(kOffset); \
} \
//根据view获得安全高度,UIViewController的self.view此值为都为0
#define ViewSafeAreaInsets(view) ({UIEdgeInsets i; if(@available(iOS 11.0, *)) {i = view.safeAreaInsets;} else {i = UIEdgeInsetsZero;} i;})
//keyWindow的顶部安全区域,实际为statusBar高度(不包括navigationBar高度),普通机型为20,iPhoneX为44
#define WindowTopSafeAreaHeight (ViewSafeAreaInsets([UIApplication sharedApplication].keyWindow).top)
//keyWindow的底部安全区域,iPhoneX高度为34,其他机型为0
#define WindowBottomSafeAreaHeight (ViewSafeAreaInsets([UIApplication sharedApplication].keyWindow).bottom)

//***********************Size**************************
#define NavBarHeight 44.f
//***********statusbar高度************
//statusBar动态总和高度,包括个人热点栏,普通机型为20或40(打开个人热点),iPhoneX为44或64(打开个人热点情况下).注意:在隐藏statusbar的页面,高度为0
#define StatusBarHeight (CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]))
//固定的statusBar高度(有些页面隐藏statusBar,StatusBarHeight为0,需要写死一个)
#define kFixedStatusBarHeight (IS_IPHONEX ? 44 : 20)

//statusbar+navigationBar高度
#define TopEdge (StatusBarHeight + NavBarHeight)//动态的高度
#define kFixedTopEdge (kFixedStatusBarHeight + NavBarHeight)//固定的顶部高度

//tabBar高度
#define TabBarHeight (IS_IPHONEX ? 49+WindowBottomSafeAreaHeight : 49.f)

//顶部的总安全高度,statusBar+navigationBar高度,普通机型为64,iPhoneX为88
#define TotalTopSafeAreaHeight (NavBarHeight + WindowTopSafeAreaHeight)
//底部的总安全高度,普通机型为TabBarHeight,49;iPhoneX为TabBarHeight+WindowBottomSafeAreaHeight,84
#define TotalBottomSafeAreaHeight TabBarHeight

#define SCALE_SCREEN  [UIScreen mainScreen].scale
#define IPHONE_HEIGHT [UIScreen mainScreen].bounds.size.height
#define IPHONE_WIDTH [UIScreen mainScreen].bounds.size.width
#define KeyWindow_Width   ([UIApplication sharedApplication].keyWindow.width)
#define KeyWindow_Height  ([UIApplication sharedApplication].keyWindow.height)
#define VIEW_HEIGHT self.view.frame.size.height
#define Psix_w IPHONE_WIDTH/375.f//跟iPhone6屏幕的比值
#define Psix_H IPHONE_HEIGHT/667.f

















#endif /* ASMacroDefineHeader_h */

