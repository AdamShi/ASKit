//
//  ASTableView.h
//  ASKit
//
//  Created by AdamShi on 2018/8/2.
//  Copyright © 2018年 AdamShi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASRefreshView.h"

@class ASTableView;
//代理方法
@protocol ASPullTableViewDelegate <NSObject>
@optional
- (void)pullTableViewRefresh:(ASTableView *)pullTableView;  //下拉刷新
- (void)pullTableViewLoadMore:(ASTableView *)pullTableView; //上拉加载
- (void)pullTableViewEndMore:(ASTableView *)pullTableView; //停止加载
@end

@interface ASTableView : UITableView
@property (nonatomic , weak) id<ASPullTableViewDelegate>pullDelegate;
//设置下拉刷新的样式
- (void)setRefeshViewWithHeaderStyle:(ASRefreshHeaderStyle)headerStyle;
//设置上拉刷新的样式
- (void)setLoadMoreViewWithFooterStyle:(ASRefreshFooterStyle)footerStyle;
//开始刷新
- (void)beginRefresh;
//停止刷新
- (void)endRefresh;
//移除下拉刷新（移除后将不再有下拉刷新，若想再次使用需要重新设置下拉刷新的样式）
- (void)removeRefreshView;
//移除上拉刷新（移除后将不再有上拉刷新，若想再次使用需要重新设置上拉刷新的样式）
- (void)removeLoadMoreView;
//已加载全部数据(footer样式)
- (void)endRefreshingWithNoMoreData;
@end


