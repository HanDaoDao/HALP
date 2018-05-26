//
//  HPMineOrderListViewController.m
//  HALP
//
//  Created by 韩钊 on 2018/5/17.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPMineOrderListViewController.h"
#import "HPMineOrderTableViewCell.h"
#import "headFile.pch"
#import "HPUser.h"
#import "HPOrder.h"
#import "MJRefresh.h"
#import "HPCantDetailViewController.h"
#import "HPExpDetailViewController.h"
#import "HPOtherDetailViewController.h"

static NSString * const kHPMineOrderTableViewCell = @"kHPMineOrderTableViewCell";

@interface HPMineOrderListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray* dataArray;
@property (nonatomic,strong) HPUser *user;
//@property (nonatomic,strong) HPOrder *order;

@end

@implementation HPMineOrderListViewController

//懒加载dataArray
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    self.user = [HPUser sharedHPUser];
    [_user initUser];
    
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.and.bottom.equalTo(self.view);
    }];
    
    [self.tableView registerClass:[HPMineOrderTableViewCell class] forCellReuseIdentifier:kHPMineOrderTableViewCell];

    if(_isCreator == 1){
        [self findMyCreateOrderList:^(NSMutableArray *array, NSError *error) {
            if (error) {
                NSLog(@"%@",error);
            }else{
                self.dataArray = array;
                NSLog(@"----%lu",(unsigned long)self.dataArray.count);
            }
        }];
    }else{
        [self findMyHelpOrderList:^(NSMutableArray *array, NSError *error) {
            if (error) {
                NSLog(@"%@",error);
            }else{
                self.dataArray = array;
                NSLog(@"----%lu",(unsigned long)self.dataArray.count);
            }
        }];
    }
    
    //当刚开始没有数据的时候，不显示cell的分割线
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    //设置下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    [self.tableView.mj_header beginRefreshing];
}

-(void)refresh{
    NSLog(@"哈哈哈");
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(targetMethod) userInfo:nil repeats:NO];
}

-(void)targetMethod{
    NSLog(@"关闭");
    //下拉刷新请求公告信息
    if(_isCreator == 1){
        [self findMyCreateOrderList:^(NSMutableArray *array, NSError *error) {
            if (error) {
                NSLog(@"%@",error);
            }else{
                self.dataArray = array;
                NSLog(@"----%lu",(unsigned long)self.dataArray.count);
            }
        }];
    }else{
        [self findMyHelpOrderList:^(NSMutableArray *array, NSError *error) {
            if (error) {
                NSLog(@"%@",error);
            }else{
                self.dataArray = array;
                NSLog(@"----%lu",(unsigned long)self.dataArray.count);
            }
        }];
    }
    [self.tableView.mj_header endRefreshing];
    [self.tableView reloadData];
}

#pragma mark - Tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;  {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HPMineOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kHPMineOrderTableViewCell forIndexPath:indexPath];
 
    HPOrder* order = nil;
    if (indexPath.row < [_dataArray count]) {//无论你武功有多高，有时也会忘记加
        order = [_dataArray objectAtIndex:indexPath.row];
    }
    cell.timeLabel.text = [NSString translateNSDateToNSString:order.startAt];
    cell.honorLabel.text = [NSString stringWithFormat:@"%@", order.orderHonor];
    switch (order.orderType) {
        case 0:
            cell.headImageView.image = [UIImage imageNamed:@"灯塔"];
            break;
        case 1:
            cell.headImageView.image = [UIImage imageNamed:@"美食头像"];
            break;
        case 2:
            cell.headImageView.image = [UIImage imageNamed:@"快递头像"];
            break;
        default:
            break;
    }
    switch (order.orderStatus) {
        case 0:
            cell.statusLabel.text = @"待接单";
            break;
        case 1:
            cell.statusLabel.text = @"进行中";
            break;
        case 2:
            cell.statusLabel.text = @"已取消";
            break;
        case 3:
            cell.statusLabel.text = @"已完成";
            break;
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    HPCantDetailViewController *cantDetailVC = [[HPCantDetailViewController alloc] init];
    cantDetailVC.hidesBottomBarWhenPushed = YES;
    HPExpDetailViewController *expDetailVC = [[HPExpDetailViewController alloc] init];
    expDetailVC.hidesBottomBarWhenPushed = YES;
    HPOtherDetailViewController *otherDetailVC = [[HPOtherDetailViewController alloc] init];
    otherDetailVC.hidesBottomBarWhenPushed = YES;
    
    HPOrder* orderDetail = nil;
    if (indexPath.row < [_dataArray count]) {//无论你武功有多高，有时也会忘记加
        orderDetail = [_dataArray objectAtIndex:indexPath.row];
    }
    switch (orderDetail.orderType) {
        case 0:
            otherDetailVC.orderDetail = orderDetail;
            otherDetailVC.isCreator = _isCreator;
            [self.navigationController pushViewController:otherDetailVC animated:YES];
            break;
        case 1:
            cantDetailVC.orderDetail = orderDetail;
            cantDetailVC.isCreator = _isCreator;
            [self.navigationController pushViewController:cantDetailVC animated:YES];
            break;
        case 2:
            expDetailVC.orderDetail = orderDetail;
            expDetailVC.isCreator = _isCreator;
            [self.navigationController pushViewController:expDetailVC animated:YES];
            break;
        default:
            break;
    }
}

-(void)findMyCreateOrderList:(findOrderBlock)callBack{
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"Order"];
    [bquery includeKey:@"orderType,orderStatus,,orderSchool,creator,helper"];
    
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        self.dataArray = nil;
        if (error) {
            NSLog(@"ERROR");
        }else{
            for (BmobObject *obj in array) {
                if ([[[obj objectForKey:@"creator"] objectForKey:@"objectId"] isEqualToString:_user.objectID]) {
                    HPOrder *addOrder = [[HPOrder alloc] init];
                    NSDictionary *dic = [NSString parseJSONStringToNSDictionary:[obj objectForKey:@"content"]];
                    HPExpressContent* expCont = [HPExpressContent yy_modelWithDictionary:dic];
                    HPCanteenContent* cantCont = [HPCanteenContent yy_modelWithDictionary:dic];
                    HPOtherContent* otherCont = [HPOtherContent yy_modelWithDictionary:dic];
                    addOrder.expContent = expCont;
                    addOrder.content = cantCont;
                    addOrder.otherContent = otherCont;
                    addOrder.objectID = obj.objectId;
                    addOrder.orderHonor = [obj objectForKey:@"orderHonor"];
                    addOrder.creator = [obj objectForKey:@"creator"];
                    addOrder.helper = [obj objectForKey:@"helper"];
                    switch ([[[obj objectForKey:@"orderType"] objectForKey:@"dataType"] integerValue]) {
                        case 0:
                            addOrder.orderType = 0;
                            break;
                        case 1:
                            addOrder.orderType = 1;
                            break;
                        case 2:
                            addOrder.orderType = 2;
                            break;
                        default:
                            break;
                    }
                    switch ([[[obj objectForKey:@"orderStatus"] objectForKey:@"dataType"] integerValue]) {
                        case 0:
                            addOrder.orderStatus = 0;
                            addOrder.startAt = obj.createdAt;
                            break;
                        case 1:
                            addOrder.orderStatus = 1;
                            addOrder.startAt = [obj objectForKey:@"startAt"];
                            break;
                        case 2:
                            addOrder.orderStatus = 2;
                            addOrder.startAt = [obj objectForKey:@"endAt"];
                            break;
                        case 3:
                            addOrder.orderStatus = 3;
                            addOrder.startAt = [obj objectForKey:@"endAt"];
                            break;
                        default:
                            break;
                    }
                    [self.dataArray addObject:addOrder];
                }
                
            }
        }
        callBack(self.dataArray,error);
    }];
}

-(void)findMyHelpOrderList:(findOrderBlock)callBack{
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"Order"];
    [bquery includeKey:@"orderType,orderStatus,,orderSchool,creator,helper"];
    
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        self.dataArray = nil;
        if (error) {
            NSLog(@"ERROR");
        }else{
            for (BmobObject *obj in array) {
                if ([[[obj objectForKey:@"helper"] objectForKey:@"objectId"] isEqualToString:_user.objectID]){
                    HPOrder *addOrder = [[HPOrder alloc] init];
                    NSDictionary *dic = [NSString parseJSONStringToNSDictionary:[obj objectForKey:@"content"]];
                    HPExpressContent* expCont = [HPExpressContent yy_modelWithDictionary:dic];
                    HPCanteenContent* cantCont = [HPCanteenContent yy_modelWithDictionary:dic];
                    HPOtherContent* otherCont = [HPOtherContent yy_modelWithDictionary:dic];
                    addOrder.expContent = expCont;
                    addOrder.content = cantCont;
                    addOrder.otherContent = otherCont;
                    addOrder.objectID = obj.objectId;
                    addOrder.orderHonor = [obj objectForKey:@"orderHonor"];
                    addOrder.creator = [obj objectForKey:@"creator"];
                    addOrder.helper = [obj objectForKey:@"helper"];
                    switch ([[[obj objectForKey:@"orderType"] objectForKey:@"dataType"] integerValue]) {
                        case 0:
                            addOrder.orderType = 0;
                            break;
                        case 1:
                            addOrder.orderType = 1;
                            break;
                        case 2:
                            addOrder.orderType = 2;
                            break;
                        default:
                            break;
                    }
                    switch ([[[obj objectForKey:@"orderStatus"] objectForKey:@"dataType"] integerValue]) {
                        case 0:
                            addOrder.orderStatus = 0;
                            addOrder.startAt = obj.createdAt;
                            break;
                        case 1:
                            addOrder.orderStatus = 1;
                            addOrder.startAt = [obj objectForKey:@"startAt"];
                            break;
                        case 2:
                            addOrder.orderStatus = 2;
                            addOrder.startAt = [obj objectForKey:@"endAt"];
                            break;
                        case 3:
                            addOrder.orderStatus = 3;
                            addOrder.startAt = [obj objectForKey:@"endAt"];
                            break;
                        default:
                            break;
                    }
                    [self.dataArray addObject:addOrder];
                }
                
            }
        }
        callBack(self.dataArray,error);
    }];
}
@end
