//
//  ASTabBarViewController.m
//  ASKit
//
//  Created by AdamShi on 2018/5/22.
//  Copyright © 2018年 AdamShi. All rights reserved.
//

#import "ASTabBarViewController.h"
#import "ASHomeViewController.h"
#import "ASVideoViewController.h"
#import "ASMessengeViewController.h"
#import "ASMySelfViewController.h"
#import "ASTabBarView.h"

@interface ASTabBarViewController ()
@property (nonatomic, strong)NSArray *titleArray;
@property (nonatomic, strong)NSArray *imgArray;
@property (nonatomic, strong)NSArray *selecteImgArray;
@property (nonatomic, strong)NSArray *VCClassNameArray;
@property (nonatomic, strong)ASTabBarView *customTabBarView;
@end

@implementation ASTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.tabBar.hidden = YES;
//    self.tabBar.barStyle = UIBarStyleBlack;
//    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
//    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    [self loadData];
    [self setUpChildViewControllers];
    [self initCustomTabBarView];
}

- (void)loadData{
    self.titleArray = @[@"首页", @"视频", @"消息", @"我的"];
    self.imgArray = @[IMAGE(@"home_normal"), IMAGE(@"mycity_normal"), IMAGE(@"message_normal"), IMAGE(@"account_normal")];
    self.selecteImgArray = @[IMAGE(@"home_highlight"), IMAGE(@"mycity_highlight"), IMAGE(@"message_highlight"), IMAGE(@"account_highlight")];
    self.VCClassNameArray = @[@"ASHomeViewController", @"ASVideoViewController", @"ASMessengeViewController", @"ASMySelfViewController"];
}
- (void)setUpChildViewControllers{
    NSMutableArray *navigationCArray = [NSMutableArray array];
    for (int i=0; i<self.VCClassNameArray.count; i++) {
        Class VCClass = NSClassFromString(self.VCClassNameArray[i]);
        UIViewController *VC = [[VCClass alloc]init];
        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:VC];
        navigation.navigationBar.hidden = YES;
        [navigationCArray addObject:navigation];
    }
    self.viewControllers = navigationCArray;
}
//在系统tabBar上添加自定义view
- (void)initCustomTabBarView{
    self.customTabBarView = [ASTabBarView getASTabBarWithFrame:self.tabBar.bounds];
    [self.customTabBarView reloadViewsWithTitleArray:self.titleArray ImgArray:self.imgArray SelecteImgArray:self.selecteImgArray];
    @weakify(self);
    self.customTabBarView.block = ^(NSInteger index) {
        @strongify(self);
        self.selectedIndex = index;
    };
    [self.tabBar addSubview:self.customTabBarView];
//    [self.customTabBarView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(UIEdgeInsetsZero);
//    }];
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
