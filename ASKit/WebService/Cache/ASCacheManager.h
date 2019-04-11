//
//  ASCacheManager.h
//  ASKit
//
//  Created by AdamShi on 2018/7/24.
//  Copyright © 2018年 AdamShi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASNetWorkingSetting.h"

@interface ASCacheManager : NSObject
/**
 * 存储网络缓存
 *
 * @param cache                 缓存字典
 * @param url                   请求的url
 * @param params                请求的参数
 * @param setting               网络参数
 */
+ (void)saveNetWorkCache:(NSDictionary *)cache URL:(NSString *)url Params:(NSMutableDictionary *)params NetWorkSetting:(ASNetWorkingSetting *)setting;

/**
 * 查找网络缓存并返回
 *
 * @param url                   请求的url
 * @param setting               网络参数
 */
+ (NSDictionary *)searchNetWorkCacheDataWithURL:(NSString *)url Params:(NSMutableDictionary *)params NetWorkSetting:(ASNetWorkingSetting *)setting;
+ (void)clearAllNetWorkCache;
@end
