//
//  HPOtherDetailViewController.m
//  HALP
//
//  Created by 韩钊 on 2018/5/8.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPOtherDetailViewController.h"
#import "HPOrderDetailCell.h"
#import "UIImageView+HPHelper.h"
#import "SVProgressHUD.h"
#import "NSDate+Time.h"
#import "NSString+JSON.h"
#import "HPDetaileCompleteViewController.h"
#import "HPLoginViewController.h"

static NSString * const kHOrderDetailViewCell = @"kHOrderDetailViewCell";

@interface HPOtherDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,copy) NSArray *array;
@property(nonatomic,copy) NSMutableArray* dataArray; 

@end

@implementation HPOtherDetailViewController

//懒加载dataArray
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self setupView];
    [self initArrayList];
}

-(void)initArrayList{
    _array = @[@"标 题:",@"需 求:"];
    
    [self.dataArray addObject:(_orderDetail.otherContent.title == nil ? @" " : _orderDetail.otherContent.title)];
    [self.dataArray addObject:(_orderDetail.otherContent.content == nil ? @" " : _orderDetail.otherContent.content)];

}

-(void)setupView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:(UITableViewStyleGrouped)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [self.tableView registerClass:[HPOrderDetailCell class] forCellReuseIdentifier:kHOrderDetailViewCell];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 80;
        }
        else if(indexPath.row == 2){
            return 80;
        }
    }
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? _array.count + 1 : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HPOrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:kHOrderDetailViewCell forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [cell setupHeadCell];
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
            cell.phoneLabel.text = _orderDetail.creator.mobilePhoneNumber;
            cell.hornorLabel.text = [NSString stringWithFormat:@"悬赏：%@",_orderDetail.orderHonor];
            
        }else  if (indexPath.row == 2) {
            [cell setupDetailCell];
            cell.detailLabel.hidden = YES;
            cell.detailTextView.hidden = NO;
            cell.titleLabel.text = _array[indexPath.row-1];
            cell.detailTextView.text = _dataArray[indexPath.row - 1];
        }
        else{
            [cell setupDetailCell];
            cell.detailTextView.hidden = YES;
            cell.detailLabel.hidden = NO;
            cell.titleLabel.text = _array[indexPath.row-1];
            cell.detailLabel.text = _dataArray[indexPath.row - 1];
        }
    }else{
        if (_isCreator) {
            [cell cancelAndCompleteCell];
            [cell.cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
            [cell.completeButton addTarget:self action:@selector(completeButtonAction) forControlEvents:UIControlEventTouchUpInside];
        }else{
            [cell acceptCell];
            [cell.acceptButton addTarget:self action:@selector(acceptButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
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
        NSLog(@"objectId:%@",orderStatus.objectId);
        NSLog(@"name:%@",[orderStatus objectForKey:@"dataType"]);
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
                    [SVProgressHUD setBackgroundColor:hpRGBHex(0x808080)];
                    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
                    [SVProgressHUD dismissWithDelay:1.5];
                }
            }];
        }else{
            [SVProgressHUD showInfoWithStatus:@"已经被接单啦"];
            [SVProgressHUD setBackgroundColor:hpRGBHex(0x808080)];
            [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
            [SVProgressHUD dismissWithDelay:1.5];
        }
    }];
}

-(void)cancelButtonAction{
    [SVProgressHUD showWithStatus:@"正在取消订单..."];
    [SVProgressHUD setBackgroundColor:hpRGBHex(0x808080)];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    NSDate *dateTime = [NSDate getCurrentTimes];
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"Order"];
    [bquery includeKey:@"orderStatus"];
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
                    [SVProgressHUD setBackgroundColor:hpRGBHex(0x808080)];
                    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
                    [SVProgressHUD dismissWithDelay:1.5];
                    [self.navigationController popViewControllerAnimated:YES];
                } else {
                    NSLog(@"%@",error);
                    [SVProgressHUD showErrorWithStatus:@"取消订单失败，请重试"];
                    [SVProgressHUD setBackgroundColor:hpRGBHex(0x808080)];
                    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
                    [SVProgressHUD dismissWithDelay:1.5];
                }
            }];
        }else if([[orderStatus objectForKey:@"dataType"] intValue] == 2){
            [SVProgressHUD showInfoWithStatus:@"已经取消啦"];
            [SVProgressHUD setBackgroundColor:hpRGBHex(0x808080)];
            [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
            [SVProgressHUD dismissWithDelay:1.5];
        }else if([[orderStatus objectForKey:@"dataType"] intValue] == 3){
            [SVProgressHUD showInfoWithStatus:@"已经完成啦"];
            [SVProgressHUD setBackgroundColor:hpRGBHex(0x808080)];
            [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
            [SVProgressHUD dismissWithDelay:1.5];
        }
        
    }];
}

-(void)completeButtonAction{
    [SVProgressHUD showWithStatus:@"正在完成订单..."];
    [SVProgressHUD setBackgroundColor:hpRGBHex(0x808080)];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    NSDate *dateTime = [NSDate getCurrentTimes];
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"Order"];
    [bquery includeKey:@"orderStatus"];
    [bquery getObjectInBackgroundWithId:_orderDetail.objectID block:^(BmobObject *object, NSError *error) {
        
        BmobObject *orderStatus = [object objectForKey:@"orderStatus"];
        if ([[orderStatus objectForKey:@"dataType"] intValue] == 1 || [[orderStatus objectForKey:@"dataType"] intValue] == 0) {
            BmobObject *orderChange = [BmobObject objectWithoutDataWithClassName:@"Order" objectId:_orderDetail.objectID];
            [orderChange setObject:dateTime forKey:@"endAt"];
            
            BmobObject *dic = [BmobObject objectWithoutDataWithClassName:@"Dictionary" objectId:@"KNrPaSSa"];
            [orderChange setObject:dic forKey:@"orderStatus"];
            
            [orderChange updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                if (isSuccessful) {
                    [SVProgressHUD showSuccessWithStatus:@"订单完成！"];
                    [SVProgressHUD setBackgroundColor:hpRGBHex(0x808080)];
                    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
                    [SVProgressHUD dismissWithDelay:1.5];
                    [self.navigationController popViewControllerAnimated:YES];
                } else {
                    NSLog(@"%@",error);
                    [SVProgressHUD showErrorWithStatus:@"订单失败，请重试"];
                    [SVProgressHUD setBackgroundColor:hpRGBHex(0x808080)];
                    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
                    [SVProgressHUD dismissWithDelay:1.5];
                }
            }];
        }else if([[orderStatus objectForKey:@"dataType"] intValue] == 2){
            [SVProgressHUD showInfoWithStatus:@"已经取消啦"];
            [SVProgressHUD setBackgroundColor:hpRGBHex(0x808080)];
            [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
            [SVProgressHUD dismissWithDelay:1.5];
        }else if([[orderStatus objectForKey:@"dataType"] intValue] == 3){
            [SVProgressHUD showInfoWithStatus:@"已经完成啦"];
            [SVProgressHUD setBackgroundColor:hpRGBHex(0x808080)];
            [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
            [SVProgressHUD dismissWithDelay:1.5];
        }
        
    }];
}

@end
