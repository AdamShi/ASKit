//
//  ASNetWorkingSetting.h
//  ASKit
//
//  Created by AdamShi on 2018/7/30.
//  Copyright © 2018年 AdamShi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASNetWorkingSetting : NSObject
//=====================================BASE================================
//@property (nonatomic, strong)NSString *URL;                           //请求链接URL
//@property (nonatomic, strong)NSMutableDictionary *params;             //请求参数

//=====================================Cach网络缓存================================
@property (nonatomic, assign)NSTimeInterval cacheTimeInterval;          //缓存有效期时间, 若为0:不需缓存
@property (nonatomic, strong)NSString *currentServerTime;               //当前服务器时间,用于判断网络缓存是否过期,如果传空,会使用系统当前时间

//=====================================Other其他================================
@property (nonatomic, assign)BOOL isShowTips;                           //是否提示吐司

+ (instancetype)defaltSetting;
@end
