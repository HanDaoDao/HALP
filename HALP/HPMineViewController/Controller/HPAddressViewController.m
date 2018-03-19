//
//  HPAddressViewController.m
//  HALP
//
//  Created by HanZhao on 2018/3/14.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPAddressViewController.h"
#import "headFile.pch"
#import "Masonry.h"
#import "HPAdd_addressViewController.h"

@interface HPAddressViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UIButton *addButton;
@property(nonatomic,strong) NSMutableArray *addressArray;

@end

@implementation HPAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self setupView];
}

-(void)setupView{
    _addButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _addButton.backgroundColor = hpRGBHex(0xFFE4B5);
    [_addButton setTitle:@"⊕ 新增收货地址" forState:UIControlStateNormal];
    [_addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_addButton setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [_addButton addTarget:self action:@selector(addAddressButton) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_addButton];

    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self.view);
        make.height.mas_equalTo(60);
    }];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.equalTo(self.view);
        make.bottom.equalTo(self.addButton.mas_top);
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:indentifier];
    }

    
    
    return cell;
}

-(void)addAddressButton{
    HPAdd_addressViewController *addAddressVC = [[HPAdd_addressViewController alloc] init];
    [self.navigationController pushViewController:addAddressVC animated:YES];
}

@end
