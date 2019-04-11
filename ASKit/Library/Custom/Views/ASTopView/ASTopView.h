//
//  ASTopView.h
//  ASKit
//
//  Created by AdamShi on 2018/5/24.
//  Copyright © 2018年 AdamShi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ASTopViewDelegate <NSObject>
- (void)backBtnAction;
@end

@interface ASTopView : UIView
@property (nonatomic, strong)UIButton *backBtn;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, assign)id <ASTopViewDelegate> delegate;
@end
