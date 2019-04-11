//
//  ASHostManager.h
//  ASKit
//
//  Created by AdamShi on 2018/7/26.
//  Copyright © 2018年 AdamShi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASHostModel.h"

#define APIBaseURL [ASHostManager ASHostAPIBaseURL]
#define ImgBaseURL [ASHostManager ASHostImgBaseURL]

@interface ASHostManager : NSObject
+ (NSString *)ASHostAPIBaseURL;//获取当前环境下的APIBaseURL
+ (NSString *)ASHostImgBaseURL;//获取当前环境下的ImgBaseURL
+ (NSMutableArray *)AllHostArray;//获取所有的网络环境
+ (NSString *)getURLWithModel:(ASHostModel *)model;//传入model,获取URL环境
+ (BOOL)judgeIsCurrentHostWithModel:(ASHostModel *)model;//判断传入的model是否是当前环境
+ (void)saveHostWithModel:(ASHostModel *)model;//传入model,保存网络环境
@end
