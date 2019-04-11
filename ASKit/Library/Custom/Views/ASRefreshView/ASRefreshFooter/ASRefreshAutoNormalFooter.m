//
//  ASRefreshAutoNormalFooter.m
//  ASKit
//
//  Created by AdamShi on 2018/8/3.
//  Copyright © 2018年 AdamShi. All rights reserved.
//

#import "ASRefreshAutoNormalFooter.h"

@implementation ASRefreshAutoNormalFooter
- (instancetype)init {
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    self.automaticallyRefresh = YES;//自动刷新,只要滑动到底部,自动刷新
    self.triggerAutomaticallyRefreshPercent = 0.1;//只要出现一点点Footer,就刷新
    self.refreshingTitleHidden = YES;
    self.automaticallyChangeAlpha = YES;//刷新结束自动隐藏
//    self.stateLabel.hidden = YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
