//
//  ASUserDefaultManager.h
//  ASKit
//
//  Created by AdamShi on 2018/6/14.
//  Copyright © 2018年 AdamShi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASUserDefaultManager : NSObject
+ (void)ASSetObject:(id)object forKey:(NSString *)key;
@end
