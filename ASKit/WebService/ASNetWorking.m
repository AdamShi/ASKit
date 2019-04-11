//
//  ASNetWorking.m
//  ASKit
//
//  Created by AdamShi on 2018/7/27.
//  Copyright © 2018年 AdamShi. All rights reserved.
//

#import "ASNetWorking.h"
#import "ASHTTPSessionManager.h"
#import "ASNetWorkingSetting.h"
#import "ASHostManager.h"
#import "ASCacheManager.h"

@interface ASNetWorking ()
@property (nonatomic, strong)AFHTTPSessionManager *manager;
@end

@implementation ASNetWorking
+ (instancetype)shareNetWorking{
    static ASNetWorking *shareNetWorking = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareNetWorking = [[ASNetWorking alloc]init];
    });
    return shareNetWorking;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.manager = [ASHTTPSessionManager shareManagerWithHostModel:nil];
    }
    return self;
}
#pragma mark - get请求基本方法
- (void)baseGetRequestWithURL:(NSString *)url Parameters:(NSMutableDictionary *)params NetWorkSetting:(ASNetWorkingSetting *)netWorkSetting Progress:(ASNetWorkingProgressBlock)progerssBlock Success:(ASNetWorkingSuccessBlock)successBlock Fail:(ASNetWorkingFailBlock)failBlock{
    if ([ASNetWorking isNetWorkCacheCanUseWithURL:url Parameters:params NetWorkSetting:netWorkSetting SuccessBlock:successBlock]) {//如果允许用网络缓存,就用缓存
        return;
    }
    [self.manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progerssBlock) {
            progerssBlock(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [ASNetWorking logURLWithTask:task Error:nil];//打印url
        if (netWorkSetting && netWorkSetting.cacheTimeInterval) {//缓存网络数据
            NSDictionary *dic = responseObject;
            NSString *serverTimeKey = @"currentServerTime";
            if ([dic.allKeys containsObject:serverTimeKey]) {
                netWorkSetting.currentServerTime = dic[@"currentServerTime"];
            }
            [ASCacheManager saveNetWorkCache:responseObject URL:url Params:params NetWorkSetting:netWorkSetting];
        }
        if (successBlock) {
            successBlock(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [ASNetWorking logURLWithTask:task Error:error];
        if (failBlock) {
            failBlock(task, error);
        }
    }];
}
#pragma mark - post请求基本方法
- (void)basePostRequestWithURL:(NSString *)url Parameters:(NSMutableDictionary *)params NetWorkSetting:(ASNetWorkingSetting *)netWorkSetting Progress:(ASNetWorkingProgressBlock)progerssBlock Success:(ASNetWorkingSuccessBlock)successBlock Fail:(ASNetWorkingFailBlock)failBlock{
    if ([ASNetWorking isNetWorkCacheCanUseWithURL:url Parameters:params NetWorkSetting:netWorkSetting SuccessBlock:successBlock]) {//如果允许用网络缓存,就用缓存
        return;
    }
    [self.manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progerssBlock) {
            progerssBlock(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [ASNetWorking logURLWithTask:task Error:nil];
        if (netWorkSetting && netWorkSetting.cacheTimeInterval) {//缓存网络数据
            NSDictionary *dic = responseObject;
            NSString *serverTimeKey = @"currentServerTime";
            if ([dic.allKeys containsObject:serverTimeKey]) {
                netWorkSetting.currentServerTime = dic[@"currentServerTime"];
            }
            [ASCacheManager saveNetWorkCache:responseObject URL:url Params:params NetWorkSetting:netWorkSetting];
        }
        if (successBlock) {
            successBlock(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [ASNetWorking logURLWithTask:task Error:error];
        if (failBlock) {
            failBlock(task, error);
        }
    }];
}
#pragma mark - 打印url
+ (void)logURLWithTask:(NSURLSessionDataTask *)task Error:(NSError *)error{
    NSString *URLStr = task.currentRequest.URL.absoluteString;
    NSString *params = [[NSString alloc] initWithData:task.currentRequest.HTTPBody encoding:NSUTF8StringEncoding];
    if (error) {
        NSLog(@"\nfail: %@?%@\n%@", URLStr, params, error);
    }else{
        NSLog(@"\nsuccess: %@?%@\n", URLStr, params);
    }
}
#pragma mark - 取消某个url请求
+ (void)cancleTaskWithURL:(NSString *)url{
    for (NSURLSessionDataTask *task in [ASNetWorking shareNetWorking].manager.tasks) {
        if ([task.currentRequest.URL.absoluteString isEqualToString:[NSString stringWithFormat:@"%@%@", APIBaseURL, url]]) {
            [task cancel];
        }
    }
}
#pragma mark - 是否可以使用缓存数据,可以使用缓存就block出去并返回yes
+ (BOOL)isNetWorkCacheCanUseWithURL:(NSString *)url Parameters:(NSMutableDictionary *)params NetWorkSetting:(ASNetWorkingSetting *)netWorkSetting SuccessBlock:(ASNetWorkingSuccessBlock)successBlock{
    if (netWorkSetting && netWorkSetting.cacheTimeInterval) {//可以使用缓存数据
        NSDictionary *dic = [ASCacheManager searchNetWorkCacheDataWithURL:url Params:params NetWorkSetting:netWorkSetting];
        if (dic) {
            if (successBlock) {
                successBlock(nil, dic);
                return YES;
            }
        }
    }
    return NO;
}
@end
