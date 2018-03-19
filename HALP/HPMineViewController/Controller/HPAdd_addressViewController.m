//
//  HPAdd_addressViewController.m
//  HALP
//
//  Created by HanZhao on 2018/3/19.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPAdd_addressViewController.h"
#import "HPNewAddressTableViewCell.h"
#import "HPAddress.h"

@interface HPAdd_addressViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSArray *contactsArray;
@property(nonatomic,strong) NSArray *addressArray;
@property(nonatomic,strong) HPAddress *oneAddress;

@end

@implementation HPAdd_addressViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.topItem.title = @" ";
    self.navigationItem.title = @"新增地址";
    
    UIBarButtonItem *saveBarButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:(UIBarButtonItemStyleDone) target:self action:@selector(saveOneAddress)];
    self.navigationItem.rightBarButtonItem = saveBarButton;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT) style:(UITableViewStyleGrouped)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];

    [self initArrayList];
}

-(void)initArrayList{
    _contactsArray = @[@"姓名：",@"电话："];
    _addressArray = @[@"东/西 区:",@"楼号宿舍号:"];
}

-(void)saveOneAddress{
    if (!_oneAddress) {
        NSLog(@"没有地址信息");
        NSArray *array = [_tableView indexPathsForVisibleRows];
        _oneAddress = [[HPAddress alloc] init];
        _oneAddress.name = array[0];
        _oneAddress.tel = array[1];
        _oneAddress.area = array[2];
        _oneAddress.detail = array[3];
    }
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:_oneAddress,@"appendAddress", nil];
    NSNotification *notification = [NSNotification notificationWithName:@"appendAddressTongzhi" object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0 ? 30 : 15;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"cell";
    HPNewAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    
    if (cell == nil) {
        cell = [[HPNewAddressTableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:indentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];


    if (indexPath.section == 0) {
        [cell setupContactsView];
        cell.titleLabel.text = [_contactsArray objectAtIndex:indexPath.row];
    }
    else if (indexPath.section == 1){
        [cell setupAddressView];
        cell.titleLabel.text = [_addressArray objectAtIndex:indexPath.row];
    }

    return cell;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return (section == 0) ? @"联系人" : @"收货地址";
}

@end
