//
//  ASTopView.m
//  ASKit
//
//  Created by AdamShi on 2018/5/24.
//  Copyright © 2018年 AdamShi. All rights reserved.
//

#import "ASTopView.h"

@implementation ASTopView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    [self addSubview:self.backBtn];
    [self addSubview:self.titleLabel];
}
- (void)backButtonClicked{
    if (self.delegate && [self.delegate respondsToSelector:@selector(backBtnAction)]) {
        [self.delegate backBtnAction];
    }
}
-(UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn.frame=CGRectMake(5, StatusBarHeight, 30, NavBarHeight);
        [_backBtn setImage:IMAGE(@"icon_back") forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_backBtn];
    }
    return _backBtn;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(80, StatusBarHeight, IPHONE_WIDTH-160, NavBarHeight)];
        _titleLabel.textColor=BlackColor;
        _titleLabel.font=[UIFont systemFontOfSize:17];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
