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
#import "HPOrder.h"
#import "HPCanteenContent.h"
#import "YYModel.h"
#import "NSString+JSON.h"
#import "MJRefresh.h"
#import "headFile.pch"

@interface HPCanteenViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIButton *button;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) HPOrder *order;
@property(nonatomic,strong) NSMutableArray* dataArray;

@end

@implementation HPCanteenViewController

//懒加载dataArray
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏"] forBarMetrics:(UIBarMetrics)UIBarMetricsDefault];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, [UIFont fontWithName:@"PingFang SC" size:18], NSFontAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    [self setupView];
    [self findOrderList:^(NSMutableArray *array, NSError *error) {
        self.dataArray = array;
        NSLog(@"obj ========== %@", self.dataArray);
    }];
    
    //当刚开始没有数据的时候，不显示cell的分割线
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    //设置下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    [self.tableView.mj_header beginRefreshing];
}

//下拉刷新使用的方法
-(void)refresh{
    NSLog(@"哈哈哈");
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(targetMethod) userInfo:nil repeats:NO];
}

-(void)targetMethod{
    NSLog(@"关闭");
    
    //下拉刷新请求公告信息
    [self findOrderList:^(NSMutableArray *array, NSError *error) {
        self.dataArray = array;
        NSLog(@"obj ========== %@", self.dataArray);
    }];
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    
}

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
    
    NSLog(@"ojbk ========== %@", self.dataArray);
    HPOrder* order = [_dataArray objectAtIndex:indexPath.row];
    NSLog(@"++++%@",[order.creator objectForKey:@"nickName"]);
    cell.nameLabel.text = [order.creator objectForKey:@"nickName"];
    
    BmobFile *iconFile = (BmobFile *)[order.creator objectForKey:@"userIcon"];
    [cell.headView sd_setImageWithURL:[NSURL URLWithString:iconFile.url] placeholderImage:[UIImage imageNamed:@"路飞"]];
    
    BmobUser *sex = [order.creator objectForKey:@"sex"];
    if ([sex.objectId isEqualToString:@"qx2fEEEM"]) {
        cell.sexView.image = [UIImage imageNamed:@"性别男"];
    }else{
        cell.sexView.image = [UIImage imageNamed:@"性别女"];
    }
    
    NSString *string ;
    string = [[NSString alloc] initWithFormat:@"%@   楼层：%@   窗口：%@", order.content.canteen, order.content.floor,order.content.window];

    cell.labelOne.text = string;
    cell.labelTwo.text = order.content.food;
    cell.labelThree.text = order.content.sendTo;
    cell.honorLabel.text = [order.orderHonor stringValue];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HPCantDetailViewController *cantDetailVC = [[HPCantDetailViewController alloc] init];
    cantDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:cantDetailVC animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

-(void)findOrderList:(findOrderBlock)callBack{
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"Order"];
    //查找GameScore表的数据
    [bquery includeKey:@"orderType,orderStatus,,orderSchool,creator,helper"];
    
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error) {
            NSLog(@"ERROR");
        }else{
            for (BmobObject *obj in array) {
                if ([[[obj objectForKey:@"orderType"] objectForKey:@"dataType"] intValue] == 1) {
                    NSLog(@"obj ========== %@", obj);
                    HPOrder *addOrder = [[HPOrder alloc] init];
                    NSDictionary *dic = [NSString parseJSONStringToNSDictionary:[obj objectForKey:@"content"]];
                    HPCanteenContent* cantCont = [HPCanteenContent yy_modelWithDictionary:dic];
                    
                    addOrder.content = cantCont;
                    addOrder.orderHonor = [obj objectForKey:@"orderHonor"];
                    addOrder.creator = [obj objectForKey:@"creator"];
                    [self.dataArray addObject:addOrder];
                }
            }
        }
        callBack(self.dataArray,error);
    }];
}

@end
