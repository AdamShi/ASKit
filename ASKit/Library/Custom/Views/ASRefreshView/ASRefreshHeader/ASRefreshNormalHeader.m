//
//  ASRefreshNormalHeader.m
//  ASKit
//
//  Created by AdamShi on 2018/8/3.
//  Copyright © 2018年 AdamShi. All rights reserved.
//

#import "ASRefreshNormalHeader.h"

@implementation ASRefreshNormalHeader
- (instancetype)init {
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    //设置状态文字
//    [self setTitle:@"下拉就刷新给你看" forState:MJRefreshStateIdle];
//    [self setTitle:@"快放开,朕要刷新了" forState:MJRefreshStatePulling];
//    [self setTitle:@"世上没有下拉刷新不了的页面,如果有,就再下拉一次" forState:MJRefreshStateRefreshing];
//    self.stateLabel.font = [UIFont systemFontOfSize:12];
//    self.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:10];
//    self.stateLabel.textColor = [UIColor blackColor];
//    self.lastUpdatedTimeLabel.textColor = [UIColor blackColor];
    
    //设置自动切换透明度(在导航栏下面自动隐藏)
    self.automaticallyChangeAlpha = YES;
    self.lastUpdatedTimeLabel.hidden = YES;//隐藏时间label
    self.stateLabel.hidden = YES;//隐藏刷新状态label
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
