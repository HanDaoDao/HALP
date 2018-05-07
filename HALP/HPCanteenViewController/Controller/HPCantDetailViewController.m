//
//  HPCantDetailViewController.m
//  HALP
//
//  Created by HanZhao on 2018/3/29.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPCantDetailViewController.h"
#import "headFile.pch"
#import "HPExpDetailCell.h"
#import "NSDate+Time.h"
#import "SVProgressHUD.h"
#import "HPLoginViewController.h"
#import "HPDetaileCompleteViewController.h"

@interface HPCantDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,copy) NSArray *array;
@property(nonatomic,copy) NSMutableArray* dataArray;           //接受的显示数据

@end

@implementation HPCantDetailViewController

//懒加载dataArray
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    [self setupView];
    [self initArrayList];
}

-(void)initArrayList{
    _array = @[@"食 堂:",@"楼 层:",@"窗 口:",@"餐 品:",@"送 至:",@"备 注:"];

    [self.dataArray addObject:_orderDetail.content.canteen];
    [self.dataArray addObject:_orderDetail.content.floor];
    [self.dataArray addObject:_orderDetail.content.window];
    [self.dataArray addObject:_orderDetail.content.food];
    [self.dataArray addObject:_orderDetail.content.sendTo];
    [self.dataArray addObject:_orderDetail.content.remark];
}

-(void)setupView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:(UITableViewStyleGrouped)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    return indexPath.section == 0 ? 80 : 50;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 80;
        }
    }
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? _array.count + 1 : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    HPExpDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[HPExpDetailCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [cell setupHeadCell];
            cell.nameLabel.text = [_orderDetail.creator objectForKey:@"nickName"];
            
            BmobFile *iconFile = (BmobFile *)[_orderDetail.creator objectForKey:@"userIcon"];
            [cell.headView sd_setImageWithURL:[NSURL URLWithString:iconFile.url] placeholderImage:[UIImage imageNamed:@"路飞"]];
            
            BmobUser *sex = [_orderDetail.creator objectForKey:@"sex"];
            if ([sex.objectId isEqualToString:@"qx2fEEEM"]) {
                cell.sexView.image = [UIImage imageNamed:@"性别男"];
            }else{
                cell.sexView.image = [UIImage imageNamed:@"性别女"];
            }
            cell.phoneLabel.text = _orderDetail.creator.mobilePhoneNumber;
            
        }else{
            [cell setupDetailCell];
            cell.expLabel.text = _array[indexPath.row-1];
            cell.expDetailLabel.text = _dataArray[indexPath.row - 1];
        }
    }else{
        [cell acceptCell];
        [cell.acceptButton addTarget:self action:@selector(acceptButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return cell;
}

-(void)acceptButtonAction{
    
    NSDate *dateTime = [NSDate getCurrentTimes];
    BmobUser *user = [BmobUser currentUser];
    if (user) {
        NSLog(@"~~~~~~~%@",user.objectId);

        BmobQuery *bquery = [BmobQuery queryWithClassName:@"Order"];
        [bquery includeKey:@"orderStatus"];
        [bquery getObjectInBackgroundWithId:_orderDetail.objectID block:^(BmobObject *object, NSError *error) {

            BmobObject *orderStatud = [object objectForKey:@"orderStatus"];
            NSLog(@"objectId:%@",orderStatud.objectId);
            NSLog(@"name:%@",[orderStatud objectForKey:@"dataType"]);
            if ([[orderStatud objectForKey:@"dataType"] intValue] == 0) {
                BmobObject *orderChange = [BmobObject objectWithoutDataWithClassName:@"Order" objectId:_orderDetail.objectID];
                [orderChange setObject:dateTime forKey:@"startAt"];

                BmobObject *dic = [BmobObject objectWithoutDataWithClassName:@"Dictionary" objectId:@"zWN3EEEM"];
                [orderChange setObject:dic forKey:@"orderStatus"];

                BmobUser *helper = [BmobUser objectWithoutDataWithClassName:@"_User" objectId:user.objectId];
                [orderChange setObject:helper forKey:@"helper"];

                [orderChange updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                    if (isSuccessful) {
                        HPDetaileCompleteViewController *completeVC = [[HPDetaileCompleteViewController alloc] init];
                        [self.navigationController pushViewController:completeVC animated:YES];
                    } else {
                        NSLog(@"%@",error);
                    }
                }];
            }else{
                [SVProgressHUD showInfoWithStatus:@"已经被接单啦"];
                [SVProgressHUD setBackgroundColor:hpRGBHex(0x808080)];
                [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
                [SVProgressHUD dismissWithDelay:1.5];
            }
        }];
    }else{
        [SVProgressHUD showInfoWithStatus:@"请先进行登录"];
        [SVProgressHUD setBackgroundColor:hpRGBHex(0x808080)];
        [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
        [SVProgressHUD dismissWithDelay:1.5];
        HPLoginViewController *loginVC = [[HPLoginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
}

@end
