//
//  ASUserDefaultManager.m
//  ASKit
//
//  Created by AdamShi on 2018/6/14.
//  Copyright © 2018年 AdamShi. All rights reserved.
//

#import "ASUserDefaultManager.h"

@implementation ASUserDefaultManager
+ (void)ASSetObject:(id)object forKey:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:object forKey:key];
    [userDefaults synchronize];
}
@end
