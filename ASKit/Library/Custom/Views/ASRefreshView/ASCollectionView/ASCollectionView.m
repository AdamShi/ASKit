//
//  ASCollectionView.m
//  ASKit
//
//  Created by AdamShi on 2018/8/2.
//  Copyright © 2018年 AdamShi. All rights reserved.
//

#import "ASCollectionView.h"
#import <MJRefresh/MJRefresh.h>

@implementation ASCollectionView
//设置下拉刷新的样式
- (void)setRefeshViewWithHeaderStyle:(ASRefreshHeaderStyle)headerStyle{
    switch (headerStyle) {
        case ASRefreshHeaderNormal:  //默认的下拉刷新控件
        {
            self.mj_header = [ASRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
        }
            break;
        case ASRefreshHeaderGif:  //带动图的下拉刷新控件
        {
            self.mj_header = [ASRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
        }
            break;
        default:
            break;
    }
}
//设置上拉刷新的样式
- (void)setLoadMoreViewWithFooterStyle:(ASRefreshFooterStyle)footerStyle{
    switch (footerStyle) {
        case ASRefreshFooterBackNormal:
        {
            self.mj_footer = [ASRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        }
            break;
        case ASRefreshFooterBackGIF:
        {
            self.mj_footer = [ASRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        }
            break;
        case ASRefreshFooterAutoNormal:
        {
            self.mj_footer = [ASRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        }
            break;
        case ASRefreshFooterAutoGIF:
        {
            self.mj_footer = [ASRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        }
            break;
        default:
            break;
    }
    @weakify(self);
    self.mj_footer.endRefreshingCompletionBlock = ^{
        @strongify(self);
        [self endLoad];
    };
}
//开始刷新
- (void)beginRefresh{
    [self.mj_header beginRefreshing];
}
//停止刷新
- (void)endRefresh{
    if (self.mj_header && [self.mj_header isRefreshing]) {
        [self.mj_header endRefreshing];
    }
    if (self.mj_footer && [self.mj_footer isRefreshing]) {
        [self.mj_footer endRefreshing];
    }
}
//移除下拉刷新（移除后将不再有下拉刷新，若想再次使用需要重新设置下拉刷新的样式）
- (void)removeRefreshView{
    if (self.mj_header) {
        [self.mj_header removeFromSuperview];
        self.mj_header = nil;
    }
}
//移除上拉刷新（移除后将不再有上拉刷新，若想再次使用需要重新设置上拉刷新的样式）
- (void)removeLoadMoreView{
    if (self.mj_footer) {
        [self.mj_footer removeFromSuperview];
        self.mj_footer = nil;
    }
}
//已加载全部数据(footer样式)
- (void)endRefreshingWithNoMoreData{
    if (self.mj_footer) {
        [self.mj_footer endRefreshingWithNoMoreData];
    }
}

- (void)refresh{
    if (self.pullDelegate && [self.pullDelegate respondsToSelector:@selector(pullTableViewRefresh:)]) {
        [self.pullDelegate pullTableViewRefresh:self];
    }
}
- (void)loadMoreData{
    if (self.pullDelegate && [self.pullDelegate respondsToSelector:@selector(pullTableViewLoadMore:)]) {
        [self.pullDelegate pullTableViewLoadMore:self];
    }
}
- (void)endLoad{
    if (self.pullDelegate && [self.pullDelegate respondsToSelector:@selector(pullTableViewEndMore:)]) {
        [self.pullDelegate pullTableViewEndMore:self];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
