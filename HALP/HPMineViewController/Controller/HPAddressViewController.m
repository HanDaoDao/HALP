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
    
    
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"appendAddressTongzhi" object:nil] subscribeNext:^(NSNotification *noti) {
        @strongify(self);
        HPAddress *address = noti.userInfo[@"appendAddress"];
        [self appendAddress:address];
        [self.tableView reloadData];
    }];
    
}

-(void)appendAddress:(HPAddress *)appendAddress{
    [self.addressArray addObject:appendAddress];
}

-(NSMutableArray *)addressArray{
    if (!_addressArray) {
        _addressArray = [NSMutableArray array];
        HPAddress *address = [[HPAddress alloc] init];
        address.name = @"韩";
        address.tel = @"18989899898";
        address.area = @"东区";
        address.detail = @"2427";
        [self.addressArray addObject:address];
    }

    return _addressArray;
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
    return _addressArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    HPAddressListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[HPAddressListTableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:identifier];
    }

    HPAddress *address = [_addressArray objectAtIndex:indexPath.row];
    cell.nameLabel.text = [address.name stringByAppendingString:@" 同学"];
    cell.telLabel.text = address.tel;
    NSString *addressString = [self addressStringMerge:address.area and:address.detail];
    cell.addressLabel.text = addressString;
    
    return cell;
}

-(NSString *)addressStringMerge:(NSString *)string1 and:(NSString *)string2{
    NSString *addressString = [NSString stringWithFormat:@"%@  ", string1];
    addressString = [addressString stringByAppendingString:string2];
    return addressString;
}

-(void)addAddressButton{
    HPAdd_addressViewController *addAddressVC = [[HPAdd_addressViewController alloc] init];
    [self.navigationController pushViewController:addAddressVC animated:YES];
}

@end
