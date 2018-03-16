//
//  HPAddressViewController.m
//  HALP
//
//  Created by HanZhao on 2018/3/14.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPAddressViewController.h"
#import "headFile.pch"

@interface HPAddressViewController ()

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UIButton *addButton;

@end

@implementation HPAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self setupView];
}

/**
 有问题。。。
 */
-(void)setupView{
    _addButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _addButton.backgroundColor = [UIColor redColor];
    _addButton.frame = CGRectMake(0, 0, VIEW_WIDTH, 60);
    [self.view addSubview:_addButton];

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT - 60) style:(UITableViewStylePlain)];
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
