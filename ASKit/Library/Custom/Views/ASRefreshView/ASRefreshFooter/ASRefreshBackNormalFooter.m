//
//  ASRefreshBackNormalFooter.m
//  ASKit
//
//  Created by AdamShi on 2018/8/3.
//  Copyright © 2018年 AdamShi. All rights reserved.
//

#import "ASRefreshBackNormalFooter.h"

@implementation ASRefreshBackNormalFooter
- (instancetype)init {
    
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    self.stateLabel.hidden = YES;
    self.automaticallyChangeAlpha = YES;//刷新结束自动隐藏
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
