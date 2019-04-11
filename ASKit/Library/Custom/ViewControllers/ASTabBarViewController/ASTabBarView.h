//
//  ASTabBarView.h
//  ASKit
//
//  Created by AdamShi on 2018/5/22.
//  Copyright © 2018年 AdamShi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ASTabBarButtonBlock)(NSInteger index);

@interface ASTabBarView : UIView
@property (nonatomic, copy)ASTabBarButtonBlock block;
+ (ASTabBarView *)getASTabBarWithFrame:(CGRect)frame;
- (void)reloadViewsWithTitleArray:(NSArray *)titleArray ImgArray:(NSArray *)imgArray SelecteImgArray:(NSArray *)selecteImgArray;
@end
