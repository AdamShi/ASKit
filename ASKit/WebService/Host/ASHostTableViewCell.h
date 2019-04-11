//
//  ASHostTableViewCell.h
//  ASKit
//
//  Created by AdamShi on 2018/7/27.
//  Copyright © 2018年 AdamShi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASHostModel.h"

@interface ASHostTableViewCell : UITableViewCell
- (void)reloadCellWithModel:(ASHostModel *)model IsSelect:(BOOL)isSelect;
@end
