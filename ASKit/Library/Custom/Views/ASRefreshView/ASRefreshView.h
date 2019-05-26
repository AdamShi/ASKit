//
//  ASRefreshView.h
//  ASKit
//t
//  Created by AdamShi on 2018/8/3.
//  Copyright © 2018年 AdamShi. All rights reserved.
//

#ifndef ASRefreshView_h
#define ASRefreshView_h

typedef NS_ENUM(NSInteger , ASRefreshHeaderStyle){//下拉刷新控件
    ASRefreshHeaderNormal = 0 ,  //默认的下拉刷新控件
    ASRefreshHeaderGif    = 1,   //带动图的下拉刷新控件(***常用***)
};
typedef NS_ENUM(NSInteger , ASRefreshFooterStyle) { //上拉加载更多控件
    ASRefreshFooterBackNormal = 0,  //默认的自动回弹(需要上拉到一定程度,才能加载.***常用***)
    ASRefreshFooterBackGIF = 1,     //带动图的自动回弹footer
    ASRefreshFooterAutoNormal = 2,  //默认的自动刷新(滑动到最后一个cell附近时,会自动预加载,不需要上拉)
    ASRefreshFooterAutoGIF = 3,     //带动图的自动刷新footer
};

#import "ASTableView.h"
#import "ASCollectionView.h"

#import "ASRefreshNormalHeader.h"
#import "ASRefreshGifHeader.h"

#import "ASRefreshBackNormalFooter.h"
#import "ASRefreshBackGifFooter.h"
#import "ASRefreshAutoNormalFooter.h"
#import "ASRefreshAutoGifFooter.h"

#define ConfigRefreshArray(array)\
for (int i=1; i<=35; i++) {\
    [array addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d",i]]];\
}\

#endif /* ASRefreshView_h */
