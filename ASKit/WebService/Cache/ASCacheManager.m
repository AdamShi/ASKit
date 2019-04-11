//
//  ASCacheManager.m
//  ASKit
//
//  Created by AdamShi on 2018/7/24.
//  Copyright © 2018年 AdamShi. All rights reserved.
//

#import "ASCacheManager.h"
#import "ASHostManager.h"
#import <YYCache/YYCache.h>

#define ASNetWorkCacheKey       @"ASNetWorkCacheKey"        //网络缓存总表
#define ASOverDueTimeKey        @"ASOverDueTimeKey"         //缓存有效截止日期
#define ASNetWorkCacheDataKey   @"ASNetWorkCacheDataKey"    //缓存数据key

@implementation ASCacheManager
+ (void)saveNetWorkCache:(NSDictionary *)cache URL:(NSString *)url Params:(NSMutableDictionary *)params NetWorkSetting:(ASNetWorkingSetting *)setting{
    if (!cache || !url.length || !setting.cacheTimeInterval) {
        return;
    }
    NSMutableDictionary *resulDic = [[NSMutableDictionary alloc]init];
    [resulDic setObject:cache forKey:ASNetWorkCacheDataKey];//存缓存数据
    if (!setting.currentServerTime.length) {//没有服务器时间就拿系统当前时间
        NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
        [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        setting.currentServerTime = [formatter stringFromDate:[NSDate date]];
    }
    NSString *overDueTimeStr = [ASCacheManager timeWithCurrentServerTimeStr:setting.currentServerTime TimeInterval:setting.cacheTimeInterval];
    [resulDic setValue:overDueTimeStr forKey:ASOverDueTimeKey];//存缓存有效截止日期
    
    NSString *cachKey = [ASCacheManager getOffLineCachKeyWithURLString:url Params:params];
    YYCache *cacheManager = [YYCache cacheWithName:ASNetWorkCacheKey];//建表
    if ([cacheManager containsObjectForKey:cachKey]) {
        [cacheManager removeObjectForKey:cachKey];
    }
    [cacheManager setObject:resulDic forKey:cachKey];
}
+ (NSDictionary *)searchNetWorkCacheDataWithURL:(NSString *)url Params:(NSMutableDictionary *)params NetWorkSetting:(ASNetWorkingSetting *)setting{
    if (!url.length) {
        return nil;
    }
    if (!setting.currentServerTime.length) {//没有服务器时间就拿系统当前时间
        NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
        [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        setting.currentServerTime = [formatter stringFromDate:[NSDate date]];
    }
    NSString *cachKey = [ASCacheManager getOffLineCachKeyWithURLString:url Params:params];
    YYCache *cacheManager = [YYCache cacheWithName:ASNetWorkCacheKey];
    if ([cacheManager containsObjectForKey:cachKey]) {
        NSDictionary *dic = (NSDictionary *)[cacheManager objectForKey:cachKey];
        if (dic && [dic.allKeys containsObject:ASOverDueTimeKey]) {
            NSString *overDueTime = dic[ASOverDueTimeKey];
            if ([ASCacheManager isCacheOverDueWithCurrentServerTime:setting.currentServerTime DeadLineTime:overDueTime]) {//缓存过期
                [cacheManager removeObjectForKey:cachKey];
                return nil;
            }
        }
        if (dic && [dic.allKeys containsObject:ASNetWorkCacheDataKey]) {
            NSDictionary *resultDic = dic[ASNetWorkCacheDataKey];
            return resultDic;
        }else{
            return nil;
        }
    }else{
        return nil;
    }
}
+ (void)clearAllNetWorkCache{
    YYCache *cacheManager = [YYCache cacheWithName:ASNetWorkCacheKey];
    [cacheManager removeAllObjects];
}

//传入当前服务器时间,及缓存有效期,得到缓存有效截止日期
+ (NSString *)timeWithCurrentServerTimeStr:(NSString *)timeStr TimeInterval:(NSTimeInterval)timeInterval{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:timeStr];
    date = [date dateByAddingTimeInterval:timeInterval];
    NSString *result = [formatter stringFromDate:date];
    return result;
}
+ (BOOL)isCacheOverDueWithCurrentServerTime:(NSString *)currentServerTime DeadLineTime:(NSString *)deadLine{//YES:缓存过期; NO:未过期
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *currentDate = [formatter dateFromString:currentServerTime];
    NSDate *overDueDate = [formatter dateFromString:deadLine];
    if ([currentDate compare:overDueDate] == NSOrderedDescending) {//过期
        return YES;
    }else{
        return NO;
    }
}
+ (NSString *)getOffLineCachKeyWithURLString:(NSString *)urlString Params:(NSMutableDictionary *)parameters{//根据链接及参数生成cachKey,即缓存的名字
    if (!parameters.allKeys.count) {
        return urlString;
    }
    //因为NSDictionary是无序的,可能导致cachKey不唯一,所以先按照键值对的键的字母顺序排序成数组
    NSArray *keysArray = [parameters allKeys];
    NSArray *sortedArray = [keysArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){//由于allKeys返回的是无序数组，这里我们要排列它们的顺序
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    NSMutableString *cachKey = [[NSMutableString alloc]initWithString:[NSString stringWithFormat:@"%@%@?", APIBaseURL, urlString]];
    for (NSString *key in sortedArray) {
        [cachKey appendString:[NSString stringWithFormat:@"%@=%@&", key, parameters[key]]];
    }
    if (cachKey.length) {
        [cachKey deleteCharactersInRange:NSMakeRange(cachKey.length-1, 1)];//删掉最后一个&
    }
    return cachKey;
}
@end
