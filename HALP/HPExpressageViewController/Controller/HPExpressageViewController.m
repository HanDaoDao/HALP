//
//  HPExpressageViewController.m
//  HALP
//
//  Created by HanZhao on 2018/1/11.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPExpressageViewController.h"
#import "Masonry.h"
#import "HPListTableViewCell.h"
#import "HPExpDetailViewController.h"
#import "headFile.pch"
#import "HPWriteOrderViewController.h"

@interface HPExpressageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIButton *button;
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation HPExpressageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏"] forBarMetrics:(UIBarMetrics)UIBarMetricsDefault];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, [UIFont fontWithName:@"PingFang SC" size:18], NSFontAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    [self setupView];
}

-(void)setupView{
    _button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _button.backgroundColor = hpRGBHex(0xFFE4B5);
    _button.layer.cornerRadius = 20;
    _button.layer.masksToBounds = YES;
    [_button setTitle:@"找人帮取快递" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [_button addTarget:self action:@selector(buttonCompleted) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_button];
    
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(30);
        make.top.mas_equalTo(self.view.mas_top).offset(10);
        make.right.mas_equalTo(self.view.mas_right).offset(-30);
        make.height.mas_equalTo(40);
    }];
    
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.button.mas_bottom).offset(10);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

-(void)buttonCompleted{
    HPWriteOrderViewController *writeOderVC = [[HPWriteOrderViewController alloc] init];
    [self.navigationController pushViewController:writeOderVC animated:YES];
}
#pragma mark - Tableview datasource and delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    HPListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[HPListTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HPExpDetailViewController *expDetailVC = [[HPExpDetailViewController alloc] init];
    expDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:expDetailVC animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
