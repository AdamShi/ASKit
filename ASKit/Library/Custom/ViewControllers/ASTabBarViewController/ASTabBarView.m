//
//  ASTabBarView.m
//  ASKit
//
//  Created by AdamShi on 2018/5/22.
//  Copyright © 2018年 AdamShi. All rights reserved.
//

#import "ASTabBarView.h"

#define TabBarBtnTag 11000

@interface ASTabBarView ()
@property (nonatomic, assign)NSInteger currentIndex;
@property (nonatomic, strong)UIButton *lastBtn;
@end

@implementation ASTabBarView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.currentIndex = 0;
        self.backgroundColor = ClearColor;
    }
    return self;
}
+ (ASTabBarView *)getASTabBarWithFrame:(CGRect)frame{
    return [[ASTabBarView alloc]initWithFrame:frame];
}
- (void)reloadViewsWithTitleArray:(NSArray *)titleArray ImgArray:(NSArray *)imgArray SelecteImgArray:(NSArray *)selecteImgArray{
    [self removeAllSubviews];
    float fWidth=self.frame.size.width/titleArray.count;
    for (int i=0; i<titleArray.count; i++) {
        UIButton *tButton=[[UIButton alloc]initWithFrame:CGRectMake(i*fWidth, 0, fWidth, self.frame.size.height)];
        [tButton setTitle:titleArray[i] forState:UIControlStateNormal];
        [tButton setTitleColor:BlackColor forState:UIControlStateNormal];
        [tButton setTitleColor:RedColor forState:UIControlStateSelected];
        tButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [tButton setImage:imgArray[i] forState:UIControlStateNormal];
        [tButton setImage:selecteImgArray[i] forState:UIControlStateSelected];
        tButton.adjustsImageWhenHighlighted=NO;
        tButton.tag = i+TabBarBtnTag;
        //设置contentAlignment来保证准确
        tButton.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        tButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //先设置title,避免图片可能的压缩导致不准确; -tButton.currentImage.size.width使得title的left为原点
        CGFloat topSpace=5, middleSpace = 2;
        tButton.titleEdgeInsets = UIEdgeInsetsMake(topSpace+middleSpace+tButton.currentImage.size.height, (tButton.width-tButton.titleLabel.intrinsicContentSize.width)/2-tButton.currentImage.size.width, 0, 0);
        tButton.imageEdgeInsets = UIEdgeInsetsMake(topSpace, (tButton.width-tButton.currentImage.size.width)/2, 0, 0);
        [tButton addTarget:self action:@selector(tButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:tButton];
        if (i == self.currentIndex) {
            tButton.selected = YES;
            self.lastBtn = tButton;
        }
    }
}
- (void)tButtonClick:(UIButton *)btn{
    NSInteger index = btn.tag-TabBarBtnTag;
    if (self.currentIndex!=index) {
        self.lastBtn.selected = NO;
        btn.selected = YES;
        self.lastBtn = btn;
        self.currentIndex = index;
        if (self.block) {
            self.block(index);
        }
    }
}
// 重写hitTest方法，让超出tabBar部分也能响应事件
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (self.clipsToBounds || self.hidden || (self.alpha == 0.f)) {
        return nil;
    }
    UIView *result = [super hitTest:point withEvent:event];
    // 如果事件发生在tabbar里面直接返回
    if (result) {
        return result;
    }
    // 这里遍历那些超出的部分就可以了，不过这么写比较通用。
    for (UIView *subview in self.subviews) {
        // 把这个坐标从tabbar的坐标系转为subview的坐标系
        CGPoint subPoint = [subview convertPoint:point fromView:self];
        result = [subview hitTest:subPoint withEvent:event];
        // 如果事件发生在subView里就返回
        if (result) {
            return result;
        }
    }
    return nil;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
