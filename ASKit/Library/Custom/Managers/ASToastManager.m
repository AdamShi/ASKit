//
//  ASToastManager.m
//  ASKit
//
//  Created by AdamShi on 2018/6/13.
//  Copyright © 2018年 AdamShi. All rights reserved.
//

#import "ASToastManager.h"

@implementation ASToastManager
+ (void)showToastWithString:(NSString *)toast{
//    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
//    [SVProgressHUD dismissWithDelay:2];
    [SVProgressHUD showInfoWithStatus:toast];
}
@end
