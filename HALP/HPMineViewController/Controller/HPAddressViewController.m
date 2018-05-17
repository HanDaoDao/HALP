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
#import "HPAddressListTableViewCell.h"
#import "HPAdd_addressViewController.h"
#import "ReactiveObjC.h"
#import "HPUser.h"

@interface HPAddressViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) HPUser *user;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UIButton *addButton;

@end

@implementation HPAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    [self addressList];
    [self setupView];
    
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"appendAddressTongzhi" object:nil] subscribeNext:^(NSNotification *noti) {
        @strongify(self);
        [self.tableView reloadData];
    }];
    
}

-(void)addressList{
    self.user = [HPUser sharedHPUser];
    [_user initUser];
//    NSLog(@"============！！！%@",self.user.addressList);
}

-(void)setupView{
    _addButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _addButton.backgroundColor = hpRGBHex(0xFFE4B5);
    [_addButton setTitle:@"⊕ 新增收货地址" forState:UIControlStateNormal];
    [_addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_addButton setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [_addButton addTarget:self action:@selector(addAddressButton) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.addButton];

    _tableView = [[UITableView alloc] initWithFrame:CGRectNull style:(UITableViewStylePlain)];
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
    return _user.addressList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:identifier];
    }

    NSString *addressString = [_user.addressList objectAtIndex:indexPath.row];
    cell.textLabel.text = addressString;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TRUE;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle ==UITableViewCellEditingStyleDelete) {//如果编辑样式为删除样式
        if (indexPath.row<[_user.addressList count]) {
            [self.user.addressList removeObjectAtIndex:indexPath.row];//移除数据源的数据
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];//移除tableView中的数据
        }
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    BmobUser *bUser = [BmobUser currentUser];
    [bUser setObject:_user.addressList forKey:@"addr"];
    [bUser updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            NSLog(@"更新ing");

        }else{
            NSLog(@"error %@",[error description]);
        }
    }];
}

-(void)addAddressButton{
    HPAdd_addressViewController *addAddressVC = [[HPAdd_addressViewController alloc] init];
    addAddressVC.user = _user;
    [self.navigationController pushViewController:addAddressVC animated:YES];
}

@end
