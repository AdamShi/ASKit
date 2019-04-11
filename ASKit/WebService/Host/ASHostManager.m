//
//  ASHostManager.m
//  ASKit
//
//  Created by AdamShi on 2018/7/26.
//  Copyright © 2018年 AdamShi. All rights reserved.
//

#import "ASHostManager.h"

#define HostAPIBaseURL @"https://www.baidu.com"
#define HostImgBaseURL @"https://www.baidu.com"

#define HostKey @"HostKey"
#define HostNameKey @"HostNameKey"
#define HostIPKey @"HostIPKey"
#define HostPortKey @"HostPortKey"
#define HostSubURLKey @"HostSubURLKey"
#define HostDNSKey @"HostDNSKey"
#define HostImgBaseURLKey @"HostImgBaseURLKey"

@interface ASHostManager ()

@end

@implementation ASHostManager
+ (NSString *)ASHostAPIBaseURL{
    NSMutableString *APIBaseURLStr = [[NSMutableString alloc]initWithString:@""];
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults] objectForKey:HostKey];
    if (dic) {
        if ([dic.allKeys containsObject:HostIPKey]) {
            NSString *ipStr = dic[HostIPKey];
            if (ipStr.length) {
                [APIBaseURLStr appendString:ipStr];
            }
        }
        if ([dic.allKeys containsObject:HostPortKey]) {
            NSString *portStr = dic[HostPortKey];
            if (portStr.length) {
                [APIBaseURLStr appendString:portStr];
            }
        }
        if ([dic.allKeys containsObject:HostSubURLKey]) {
            NSString *subURLStr = dic[HostSubURLKey];
            if (subURLStr.length) {
                [APIBaseURLStr appendString:subURLStr];
            }
        }
    }else{
        APIBaseURLStr = [[NSMutableString alloc]initWithString:HostAPIBaseURL];
    }
    return APIBaseURLStr;
}
+ (NSString *)ASHostImgBaseURL{
    NSMutableString *APIBaseURLStr = [[NSMutableString alloc]initWithString:@""];
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults] objectForKey:HostKey];
    if (dic) {
        if ([dic.allKeys containsObject:HostImgBaseURLKey]) {
            NSString *ipStr = dic[HostImgBaseURLKey];
            if (ipStr.length) {
                [APIBaseURLStr appendString:ipStr];
            }
        }
    }else{
        APIBaseURLStr = [[NSMutableString alloc]initWithString:HostImgBaseURL];
    }
    return APIBaseURLStr;
}
+ (BOOL)judgeIsCurrentHostWithModel:(ASHostModel *)model{
    if (model) {
        NSString *url = [ASHostManager getURLWithModel:model];
        return [url isEqualToString:APIBaseURL] ? YES : NO;
    }else{
        return NO;
    }
}
+ (NSString *)getURLWithModel:(ASHostModel *)model{
    if (model && model.hostIP && model.hostIP.length) {
        NSMutableString *url = [[NSMutableString alloc] initWithString:model.hostIP];
        if (model.hostPort && model.hostPort.length) {
            [url appendString:model.hostPort];
        }
        if (model.hostSubURL && model.hostSubURL.length) {
            [url appendString:model.hostSubURL];
        }
        return url;
    }else{
        return @"";
    }
}
+ (void)saveHostWithModel:(ASHostModel *)model{
    if (model) {
        NSDictionary *dic = model.mj_keyValues;
        [[NSUserDefaults standardUserDefaults] setObject:dic forKey:HostKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
+ (NSMutableArray *)AllHostArray{
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    ASHostModel *model = [[ASHostModel alloc]init];
    //正式上线环境
    model.hostName = @"正式环境";
    model.hostIP = @"https://api.baidu.cn";
    model.hostPort = @"";
    model.hostSubURL = @"";
    model.hostImgBaseURL = @"https://static.baidu.cn";
    [mutableArray addObject:model];
    
    //测试环境
    model = [[ASHostModel alloc]init];
    model.hostName = @"测试环境";
    model.hostIP = @"https://api.baidu.cn";
    model.hostPort = @"";
    model.hostSubURL = @"";
    model.hostImgBaseURL = @"https://static.baidu.cn";
    [mutableArray addObject:model];
    
    //刘亦菲环境
    model = [[ASHostModel alloc]init];
    model.hostName = @"刘亦菲环境";
    model.hostIP = @"https://192.168.1.1";
    model.hostPort = @"8888";
    model.hostSubURL = @"mobilServer";
    model.hostImgBaseURL = @"https://192.168.1.9:9999";
    [mutableArray addObject:model];
    
    return mutableArray;
}
@end
