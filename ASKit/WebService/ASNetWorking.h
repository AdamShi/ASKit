//
//  ASNetWorking.h
//  ASKit
//
//  Created by AdamShi on 2018/7/27.
//  Copyright © 2018年 AdamShi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ASNetWorkingProgressBlock)(NSProgress * _Nonnull);
typedef void (^ASNetWorkingSuccessBlock)(NSURLSessionDataTask * task, id _Nullable);
typedef void (^ASNetWorkingFailBlock)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull);
@interface ASNetWorking : NSObject
+ (instancetype)shareNetWorking;
+ (void)cancleTaskWithURL:(NSString *)url;//取消某个url请求
@end
