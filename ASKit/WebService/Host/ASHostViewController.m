//
//  ASHostViewController.m
//  ASKit
//
//  Created by AdamShi on 2018/7/27.
//  Copyright © 2018年 AdamShi. All rights reserved.
//

#import "ASHostViewController.h"
#import "ASHostTableViewCell.h"
#import "ASHostManager.h"

@interface ASHostViewController ()<ASTopViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *hostTV;
@end

@implementation ASHostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.topView.delegate = self;
    self.topView.titleLabel.text = @"网络环境选择";
    [self.view addSubview:self.hostTV];
}
-(void)backBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [ASHostManager AllHostArray].count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cellID";
    ASHostTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ASHostTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if ([ASHostManager AllHostArray].count > indexPath.row) {
        ASHostModel *model = [[ASHostManager AllHostArray] objectAtIndex:indexPath.row];
        [cell reloadCellWithModel:model IsSelect:[ASHostManager judgeIsCurrentHostWithModel:model]];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([ASHostManager AllHostArray].count > indexPath.row) {
        ASHostModel *model = [[ASHostManager AllHostArray] objectAtIndex:indexPath.row];
        [ASHostManager saveHostWithModel:model];
        [self.hostTV reloadData];
    }
}
-(UITableView *)hostTV{
    if (!_hostTV) {
        _hostTV = [[UITableView alloc]initWithFrame:CGRectMake(0, self.topView.bottom, IPHONE_WIDTH, IPHONE_HEIGHT-self.topView.height) style:UITableViewStylePlain];
        _hostTV.delegate = self;
        _hostTV.dataSource = self;
    }
    return _hostTV;
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
