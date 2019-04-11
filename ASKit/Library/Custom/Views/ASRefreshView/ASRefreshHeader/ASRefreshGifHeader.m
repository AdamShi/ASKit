//
//  ASRefreshGifHeader.m
//  ASKit
//
//  Created by AdamShi on 2018/8/3.
//  Copyright © 2018年 AdamShi. All rights reserved.
//

#import "ASRefreshGifHeader.h"
#import "ASRefreshView.h"

@implementation ASRefreshGifHeader
- (instancetype)init {
    
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    NSMutableArray *refreshImgArray = [NSMutableArray array];//下拉刷新图片数组
    ConfigRefreshArray(refreshImgArray)
    [self setImages:refreshImgArray forState:MJRefreshStateIdle];//随着下拉或者上拉改变动画(普通状态)
//    [header setImages:aArray duration:1.225 forState:MJRefreshStatePulling];//一松开就开始刷新的状态动画
    [self setImages:refreshImgArray duration:1.225 forState:MJRefreshStateRefreshing];//正在刷新动画
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
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
