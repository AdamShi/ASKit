//
//  ASBaseViewController.m
//  ASKit
//
//  Created by AdamShi on 2018/5/24.
//  Copyright © 2018年 AdamShi. All rights reserved.
//

#import "ASBaseViewController.h"

@interface ASBaseViewController ()

@end

@implementation ASBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(TopEdge);
    }];
}

-(UIView *)topView{
    if (!_topView) {
        _topView = [[ASTopView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, TopEdge)];
        _topView.hidden = YES;
    }
    return _topView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
