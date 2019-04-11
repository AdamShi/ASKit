//
//  ASRefreshBackGifFooter.m
//  ASKit
//
//  Created by AdamShi on 2018/8/3.
//  Copyright © 2018年 AdamShi. All rights reserved.
//

#import "ASRefreshBackGifFooter.h"
#import "ASRefreshView.h"

@implementation ASRefreshBackGifFooter
- (instancetype)init {
    
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    NSMutableArray *aArray = [NSMutableArray array];//下拉刷新图片数组
    ConfigRefreshArray(aArray)
    [self setImages:aArray forState:MJRefreshStateIdle];//随着下拉或者上拉改变动画(普通状态)
//    [footer setImages:aArray duration:1.225 forState:MJRefreshStatePulling];//一松开就开始刷新的状态动画
    [self setImages:aArray duration:1.225 forState:MJRefreshStateRefreshing];//正在刷新动画
    
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
