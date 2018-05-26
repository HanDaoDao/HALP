//
//  HPCanteenViewController.m
//  HALP
//
//  Created by HanZhao on 2018/1/11.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPCanteenViewController.h"
#import "Masonry.h"
#import "HPCantOrderViewController.h"
#import "HPListTableViewCell.h"
#import "HPCantDetailViewController.h"
#import "HPCanteenContent.h"
#import "YYModel.h"
#import "NSString+JSON.h"
#import "MJRefresh.h"
#import "headFile.pch"
#import "HPLoginViewController.h"

@interface HPCanteenViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIButton *button;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) HPOrder *order;
@property (nonatomic,strong) HPUser *user;
@property (nonatomic,strong) NSMutableArray* dataArray;

@end

@implementation HPCanteenViewController

//懒加载dataArray
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [SVProgressHUD dismiss];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _user = [HPUser sharedHPUser];
    [_user initUser];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏"] forBarMetrics:(UIBarMetrics)UIBarMetricsDefault];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, [UIFont fontWithName:@"PingFang SC" size:18], NSFontAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    [self setupView];
    //当刚开始没有数据的时候，不显示cell的分割线
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    //设置下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self findOrderList:^(NSMutableArray *array, NSError *error) {
            if (error) {
                NSLog(@"error:%@",error);
            }
            else{
                self.dataArray = array;
                [self.tableView.mj_header endRefreshing];
                [self.tableView reloadData];
            }
        }];
    }];
    [self.tableView.mj_header beginRefreshing];
}

//下拉刷新使用的方法
//-(void)refresh{
//    NSLog(@"哈哈哈");
//    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(targetMethod) userInfo:nil repeats:NO];
//}

//-(void)targetMethod{
//    NSLog(@"关闭");
//    [self.tableView.mj_header endRefreshing];
//}

-(void)setupView{
    _button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _button.backgroundColor = hpRGBHex(0xFFE4B5);
    _button.layer.cornerRadius = 20;
    _button.layer.masksToBounds = YES;
    [_button setTitle:@"帮我带饭" forState:UIControlStateNormal];
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
    HPCantOrderViewController *cantOderVC = [[HPCantOrderViewController alloc] init];
    cantOderVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:cantOderVC animated:YES];
}

#pragma mark - Tableview datasource and delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    HPListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[HPListTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    
    HPOrder* order = nil;
    if (indexPath.row < [_dataArray count]) {//无论你武功有多高，有时也会忘记加
        order = [_dataArray objectAtIndex:indexPath.row];
    }
    cell.nameLabel.text = [order.creator objectForKey:@"nickName"];
    
    BmobFile *iconFile = (BmobFile *)[order.creator objectForKey:@"userIcon"];
    [cell.headView sd_setImageWithURL:[NSURL URLWithString:iconFile.url] placeholderImage:[UIImage imageNamed:@"路飞"]];
    
    BmobUser *sex = [order.creator objectForKey:@"sex"];
    if ([sex.objectId isEqualToString:@"qx2fEEEM"]) {
        cell.sexView.image = [UIImage imageNamed:@"性别男"];
    }else{
        cell.sexView.image = [UIImage imageNamed:@"性别女"];
    }
    
    NSString *string1,*string2 ;
    string1 = [[NSString alloc] initWithFormat:@"%@   楼层：%@   窗口：%@", order.content.canteen, order.content.floor,order.content.window];
    string2 = [[NSString alloc] initWithFormat:@"送至：%@",order.content.sendTo];
    
    cell.labelOne.text = string1;
    cell.labelTwo.text = order.content.food;
    cell.labelThree.text = string2;
    cell.honorLabel.text = [order.orderHonor stringValue];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HPCantDetailViewController *cantDetailVC = [[HPCantDetailViewController alloc] init];
    cantDetailVC.hidesBottomBarWhenPushed = YES;
    
    HPOrder* orderDetail = nil;
    if (indexPath.row < [_dataArray count]) {//无论你武功有多高，有时也会忘记加
        orderDetail = [_dataArray objectAtIndex:indexPath.row];
    }
    if (_user) {
        cantDetailVC.orderDetail = orderDetail;
        cantDetailVC.isCreator = [self isOrderCreatorMakeure:orderDetail.creator];
        [self.navigationController pushViewController:cantDetailVC animated:YES];
    }else{
        [SVProgressHUD showInfoWithStatus:@"请先进行登录"];
        [SVProgressHUD setHelpBackgroudViewAndDismissWithDelay:1.5];
        HPLoginViewController *loginVC = [[HPLoginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

-(void)findOrderList:(findOrderBlock)callBack{
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"Order"];
    [bquery includeKey:@"orderType,orderStatus,,orderSchool,creator,helper"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        self.dataArray = nil;
        if (error) {
            NSLog(@"ERROR");
        }else{
            for (BmobObject *obj in array) {
                if ([[[obj objectForKey:@"orderType"] objectForKey:@"dataType"] intValue] == 1) {
                    if ([[[obj objectForKey:@"orderStatus"] objectForKey:@"dataType"] integerValue] == 0) {
                        HPOrder *addOrder = [[HPOrder alloc] init];
                        NSDictionary *dic = [NSString parseJSONStringToNSDictionary:[obj objectForKey:@"content"]];
                        HPCanteenContent* cantCont = [HPCanteenContent yy_modelWithDictionary:dic];
                        addOrder.objectID = obj.objectId;
                        addOrder.content = cantCont;
                        addOrder.orderHonor = [obj objectForKey:@"orderHonor"];
                        addOrder.creator = [obj objectForKey:@"creator"];
                        [self.dataArray addObject:addOrder];
                    }
                }
            }
        }
        callBack(self.dataArray,error);
    }];
}

-(Boolean)isOrderCreatorMakeure:(HPUser *)orderUser{
    BmobUser *user = [BmobUser currentUser];
    if ([orderUser.objectId isEqualToString:user.objectId]) {
        return true;
    }else{
        return false;
    }
}

@end
