//
//  ASNetWorkingSetting.m
//  ASKit
//
//  Created by AdamShi on 2018/7/30.
//  Copyright © 2018年 AdamShi. All rights reserved.
//

#import "ASNetWorkingSetting.h"

@implementation ASNetWorkingSetting
+ (instancetype)defaltSetting{
    return [[ASNetWorkingSetting alloc]init];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cacheTimeInterval = 0;
        self.currentServerTime = @"";
        self.isShowTips = NO;
    }
    return self;
}
@end
