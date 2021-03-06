//
//  HPExpDetailViewController.m
//  HALP
//
//  Created by HanZhao on 2018/3/16.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPExpDetailViewController.h"
#import "Masonry.h"
#import "headFile.pch"
#import "HPOrderDetailCell.h"
#import "UIImageView+HPHelper.h"
#import "NSDate+Time.h"
#import "HPDetaileCompleteViewController.h"
#import "NSString+JSON.h"
#import "SVProgressHUD.h"
#import "SVProgressHUD+HPHelper.h"
#import "HPLoginViewController.h"

@interface HPExpDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,copy) NSArray *array;
@property(nonatomic,copy) NSMutableArray* dataArray;           //接受的显示数据

@end

@implementation HPExpDetailViewController

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
    _array = @[@"快 递:",@"位 置:",@"包 裹:",@"收件人:",@"取件号:",@"送 至:",@"备 注:"];
    [self.dataArray addObject: (_orderDetail.expContent.company == nil ? @" " : _orderDetail.expContent.company)];
    [self.dataArray addObject: (_orderDetail.expContent.loaction == nil ? @" " : _orderDetail.expContent.loaction)];
    [self.dataArray addObject: (_orderDetail.expContent.size == nil ? @" " : _orderDetail.expContent.size)];
    [self.dataArray addObject: (_orderDetail.expContent.receiver == nil ? @" " : _orderDetail.expContent.receiver)];
    [self.dataArray addObject: (_orderDetail.expContent.number == nil ? @" " : _orderDetail.expContent.number)];
    [self.dataArray addObject: (_orderDetail.expContent.sendTo == nil ? @" " : _orderDetail.expContent.sendTo)];
    [self.dataArray addObject: (_orderDetail.expContent.remark == nil ? @" " : _orderDetail.expContent.remark)];

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
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 80;
        }else{
            return 40;
        }
    }else{
        if (_isCreator) {
            return 85;
        }else{
            return 40;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? _array.count + 1 : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    HPOrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    if (cell == nil) {
        cell = [[HPOrderDetailCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [cell setupHeadCell];
            if (_isCreator == 1) {
                if (_orderDetail.orderStatus == 0 || _orderDetail.orderStatus == 2) {
                    cell.nameLabel.text = [_orderDetail.creator objectForKey:@"nickName"];
                    
                    BmobFile *iconFile = (BmobFile *)[_orderDetail.creator objectForKey:@"userIcon"];
                    [cell.headView sd_setImageWithURL:[NSURL URLWithString:iconFile.url] placeholderImage:[UIImage imageNamed:@"路飞"]];
                    [cell.headView HPHeadimageBrowser];
                    
                    BmobUser *sex = [_orderDetail.creator objectForKey:@"sex"];
                    if ([sex.objectId isEqualToString:@"qx2fEEEM"]) {
                        cell.sexView.image = [UIImage imageNamed:@"性别男"];
                    }else{
                        cell.sexView.image = [UIImage imageNamed:@"性别女"];
                    }
                }else{
                    cell.nameLabel.text = [_orderDetail.helper objectForKey:@"nickName"];
                    
                    BmobFile *iconFile = (BmobFile *)[_orderDetail.helper objectForKey:@"userIcon"];
                    [cell.headView sd_setImageWithURL:[NSURL URLWithString:iconFile.url] placeholderImage:[UIImage imageNamed:@"路飞"]];
                    [cell.headView HPHeadimageBrowser];
                    
                    BmobUser *sex = [_orderDetail.helper objectForKey:@"sex"];
                    if ([sex.objectId isEqualToString:@"qx2fEEEM"]) {
                        cell.sexView.image = [UIImage imageNamed:@"性别男"];
                    }else{
                        cell.sexView.image = [UIImage imageNamed:@"性别女"];
                    }
                }
            }else{
                cell.nameLabel.text = [_orderDetail.creator objectForKey:@"nickName"];
                
                BmobFile *iconFile = (BmobFile *)[_orderDetail.creator objectForKey:@"userIcon"];
                [cell.headView sd_setImageWithURL:[NSURL URLWithString:iconFile.url] placeholderImage:[UIImage imageNamed:@"路飞"]];
                [cell.headView HPHeadimageBrowser];
                
                BmobUser *sex = [_orderDetail.creator objectForKey:@"sex"];
                if ([sex.objectId isEqualToString:@"qx2fEEEM"]) {
                    cell.sexView.image = [UIImage imageNamed:@"性别男"];
                }else{
                    cell.sexView.image = [UIImage imageNamed:@"性别女"];
                }
            }
           
            cell.phoneLabel.text = _orderDetail.creator.mobilePhoneNumber;
            cell.hornorLabel.text = [NSString stringWithFormat:@"悬赏：%@",_orderDetail.orderHonor];
        }else{
            [cell setupDetailCell];
            cell.detailLabel.hidden = NO;
            cell.detailTextView.hidden = YES;
            cell.titleLabel.text = _array[indexPath.row-1];
            cell.detailLabel.text = _dataArray[indexPath.row - 1];
        }
    }else{
        if (_isCreator == 1) {
            if(_orderDetail.orderStatus == 3){
                [cell acceptCell];
                [cell.acceptButton setTitle:@"订 单 已 完 成" forState:(UIControlStateNormal)];
            }else if (_orderDetail.orderStatus == 2){
                [cell acceptCell];
                [cell.acceptButton setTitle:@"订 单 已 取 消" forState:(UIControlStateNormal)];
            }else{
                [cell cancelAndCompleteCell];
                [cell.cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
                [cell.completeButton addTarget:self action:@selector(completeButtonAction) forControlEvents:UIControlEventTouchUpInside];
            }
        }else{
            [cell acceptCell];
            //如果订单已经接收，帮助者的订单详情页面按钮不再显示
            if(_orderDetail.orderStatus == 1){
                [cell.acceptButton setTitle:@"订 单 进 行 中" forState:(UIControlStateNormal)];
            }else if (_orderDetail.orderStatus == 2){
                [cell.acceptButton setTitle:@"订 单 已 取 消" forState:(UIControlStateNormal)];
            }else if (_orderDetail.orderStatus == 3){
                [cell.acceptButton setTitle:@"订 单 已 完 成" forState:(UIControlStateNormal)];
            }else if (_orderDetail.orderStatus == 0){
                [cell.acceptButton addTarget:self action:@selector(acceptButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
            }
        }
    }
    return cell;
}

-(void)acceptButtonAction{
    [SVProgressHUD showWithStatus:@"正在接单..."];
    [SVProgressHUD setBackgroundColor:hpRGBHex(0x808080)];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    NSDate *dateTime = [NSDate getCurrentTimes];
    BmobUser *user = [BmobUser currentUser];
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"Order"];
    [bquery includeKey:@"orderStatus"];
    [bquery getObjectInBackgroundWithId:_orderDetail.objectID block:^(BmobObject *object, NSError *error) {
        
        BmobObject *orderStatus = [object objectForKey:@"orderStatus"];
        if ([[orderStatus objectForKey:@"dataType"] intValue] == 0) {
            BmobObject *orderChange = [BmobObject objectWithoutDataWithClassName:@"Order" objectId:_orderDetail.objectID];
            [orderChange setObject:dateTime forKey:@"startAt"];
            
            BmobObject *dic = [BmobObject objectWithoutDataWithClassName:@"Dictionary" objectId:@"zWN3EEEM"];
            [orderChange setObject:dic forKey:@"orderStatus"];
            
            BmobUser *helper = [BmobUser objectWithoutDataWithClassName:@"_User" objectId:user.objectId];
            [orderChange setObject:helper forKey:@"helper"];
            
            [orderChange updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                if (isSuccessful) {
                    HPDetaileCompleteViewController *completeVC = [[HPDetaileCompleteViewController alloc] init];
                    completeVC.time = [NSString getCurrentTimes];
                    [self.navigationController pushViewController:completeVC animated:YES];
                } else {
                    NSLog(@"%@",error);
                    [SVProgressHUD showErrorWithStatus:@"接单失败，请重试"];
                    [SVProgressHUD setHelpBackgroudViewAndDismissWithDelay:1.5];
                }
            }];
        }else{
            [SVProgressHUD showInfoWithStatus:@"已经被接单啦"];
            [SVProgressHUD setHelpBackgroudViewAndDismissWithDelay:1.5];
        }
    }];
}

-(void)cancelButtonAction{
    [SVProgressHUD showWithStatus:@"正在取消订单..."];
    [SVProgressHUD setBackgroundColor:hpRGBHex(0x808080)];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    NSDate *dateTime = [NSDate getCurrentTimes];
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"Order"];
    [bquery includeKey:@"orderStatus,helper"];
    [bquery getObjectInBackgroundWithId:_orderDetail.objectID block:^(BmobObject *object, NSError *error) {
        
        BmobObject *orderStatus = [object objectForKey:@"orderStatus"];
        if ([[orderStatus objectForKey:@"dataType"] intValue] == 1 || [[orderStatus objectForKey:@"dataType"] intValue] == 0) {
            BmobObject *orderChange = [BmobObject objectWithoutDataWithClassName:@"Order" objectId:_orderDetail.objectID];
            [orderChange setObject:dateTime forKey:@"endAt"];
            
            BmobObject *dic = [BmobObject objectWithoutDataWithClassName:@"Dictionary" objectId:@"RwmPcccq"];
            [orderChange setObject:dic forKey:@"orderStatus"];
            
            [orderChange updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                if (isSuccessful) {
                    [SVProgressHUD showSuccessWithStatus:@"取消成功！"];
                    [SVProgressHUD setHelpBackgroudViewAndDismissWithDelay:1.5];
                    [self.navigationController popViewControllerAnimated:YES];
                } else {
                    NSLog(@"%@",error);
                    [SVProgressHUD showErrorWithStatus:@"取消订单失败，请重试"];
                    [SVProgressHUD setHelpBackgroudViewAndDismissWithDelay:1.5];
                }
            }];
        }else if([[orderStatus objectForKey:@"dataType"] intValue] == 2){
            [SVProgressHUD showInfoWithStatus:@"已经取消啦"];
            [SVProgressHUD setHelpBackgroudViewAndDismissWithDelay:1.5];
        }else if([[orderStatus objectForKey:@"dataType"] intValue] == 3){
            [SVProgressHUD showInfoWithStatus:@"已经完成啦"];
            [SVProgressHUD setHelpBackgroudViewAndDismissWithDelay:1.5];
        }
        
    }];
}

-(void)completeButtonAction{
    [SVProgressHUD showWithStatus:@"正在完成订单..."];
    [SVProgressHUD setBackgroundColor:hpRGBHex(0x808080)];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    NSDate *dateTime = [NSDate getCurrentTimes];
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"Order"];
    [bquery includeKey:@"orderStatus,helper"];
    [bquery getObjectInBackgroundWithId:_orderDetail.objectID block:^(BmobObject *object, NSError *error) {
        
        BmobObject *orderStatus = [object objectForKey:@"orderStatus"];
        if ([[orderStatus objectForKey:@"dataType"] intValue] == 1 || [[orderStatus objectForKey:@"dataType"] intValue] == 0) {
            BmobObject *orderChange = [BmobObject objectWithoutDataWithClassName:@"Order" objectId:_orderDetail.objectID];
            [orderChange setObject:dateTime forKey:@"endAt"];
            
            BmobObject *dic = [BmobObject objectWithoutDataWithClassName:@"Dictionary" objectId:@"KNrPaSSa"];
            [orderChange setObject:dic forKey:@"orderStatus"];
            
            //完成订单时，荣誉值改变。。。。
            
            [orderChange updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                if (isSuccessful) {
                    [SVProgressHUD showSuccessWithStatus:@"订单完成！"];
                    [SVProgressHUD setHelpBackgroudViewAndDismissWithDelay:1.5];
                    [self.navigationController popViewControllerAnimated:YES];
                } else {
                    NSLog(@"%@",error);
                    [SVProgressHUD showErrorWithStatus:@"订单失败，请重试"];
                    [SVProgressHUD setHelpBackgroudViewAndDismissWithDelay:1.5];
                }
            }];
        }else if([[orderStatus objectForKey:@"dataType"] intValue] == 2){
            [SVProgressHUD showInfoWithStatus:@"已经取消啦"];
            [SVProgressHUD setHelpBackgroudViewAndDismissWithDelay:1.5];
        }else if([[orderStatus objectForKey:@"dataType"] intValue] == 3){
            [SVProgressHUD showInfoWithStatus:@"已经完成啦"];
            [SVProgressHUD setHelpBackgroudViewAndDismissWithDelay:1.5];
        }
        
    }];
}
@end

