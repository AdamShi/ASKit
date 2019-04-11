//
//  ASHostTableViewCell.m
//  ASKit
//
//  Created by AdamShi on 2018/7/27.
//  Copyright © 2018年 AdamShi. All rights reserved.
//

#import "ASHostTableViewCell.h"
#import "ASHostManager.h"

@interface ASHostTableViewCell ()
@property (nonatomic, strong)UILabel *hostNameLabel;
@property (nonatomic, strong)UILabel *hostURLLabel;
@property (nonatomic, strong)UIImageView *selectImg;
@end

@implementation ASHostTableViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    [self.contentView addSubview:self.hostNameLabel];
    [self.contentView addSubview:self.hostURLLabel];
    [self.contentView addSubview:self.selectImg];
}
- (void)reloadCellWithModel:(ASHostModel *)model IsSelect:(BOOL)isSelect{
    if (model) {
        if (model.hostName.length) {
            self.hostNameLabel.text = model.hostName;
        }
        if (model.hostIP.length) {
            self.hostURLLabel.text = [ASHostManager getURLWithModel:model];
        }
        if (isSelect) {
            self.imageView.hidden = NO;
        }else{
            self.imageView.hidden = YES;
        }
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(UILabel *)hostNameLabel{
    if (!_hostNameLabel) {
        _hostNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, self.width, 20)];
    }
    return _hostNameLabel;
}
-(UILabel *)hostURLLabel{
    if (!_hostURLLabel) {
        _hostURLLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, self.width, 20)];
    }
    return _hostURLLabel;
}
-(UIImageView *)selectImg{
    if (!_selectImg) {
        _selectImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    }
    return _selectImg;
}
@end
