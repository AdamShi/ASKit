//
//  ASLoadingManager.m
//  ASKit
//
//  Created by AdamShi on 2018/6/13.
//  Copyright © 2018年 AdamShi. All rights reserved.
//

#import "ASLoadingManager.h"

@interface ASLoadingManager ()

@end

@implementation ASLoadingManager
static ASLoadingManager *shareInstance;
+ (ASLoadingManager *)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[ASLoadingManager alloc]init];
    });
    return shareInstance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configLoadding];
    }
    return self;
}
- (void)configLoadding{
    
}
- (void)startLoading{
//    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
}
- (void)stopLoading{
    [SVProgressHUD dismiss];
}
+ (void)startLoading{
    [[ASLoadingManager shareInstance] startLoading];
}
+ (void)stopLoading{
    [[ASLoadingManager shareInstance] stopLoading];
}
@end
