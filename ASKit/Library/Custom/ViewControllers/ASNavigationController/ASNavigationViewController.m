//
//  ASNavigationViewController.m
//  ASKit
//
//  Created by AdamShi on 2018/5/24.
//  Copyright © 2018年 AdamShi. All rights reserved.
//

#import "ASNavigationViewController.h"

@interface ASNavigationViewController () <UINavigationControllerDelegate>
@property (nonatomic, weak) id PopDelegate;//解决侧滑手势失效
@end

@implementation ASNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //解决侧滑手势失效
    self.PopDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
}
//解决侧滑手势失效
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (viewController == self.viewControllers[0]) {
        self.interactivePopGestureRecognizer.delegate = self.PopDelegate;
    }else{
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {//解决push时隐藏Tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    
    // 修改tabBar的frame,解决iPhoneX下push页面时tabBar跳动的问题
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
    self.tabBarController.tabBar.frame = frame;
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
