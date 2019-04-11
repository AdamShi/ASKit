//
//  ASHTTPSessionManager.h
//  ASKit
//
//  Created by AdamShi on 2018/7/24.
//  Copyright © 2018年 AdamShi. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "ASHostModel.h"

@interface ASHTTPSessionManager : AFHTTPSessionManager
+ (instancetype)shareManagerWithHostModel:(ASHostModel *)model;
@end
