//
//  HPMineViewController.m
//  HALP
//
//  Created by HanZhao on 2018/1/11.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPMineViewController.h"
#import "HPHonorViewController.h"
#import "HPUserViewController.h"
#import "HPAddressViewController.h"
#import "HPUser.h"
#import "AFNetworking.h"
#import "HPLoginViewController.h"

@interface HPMineViewController()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *mineTableView;
@property(nonatomic,copy) NSArray *mineListNames;
@property(nonatomic,copy) NSDictionary *personData;
@property(nonatomic,strong) HPUser *user;

@end

@implementation HPMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //添加通知（头像，昵称）
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(modifiy)
                                                 name:@"changeHeadTongzhi"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(modifiy)
                                                 name:@"changeNameTongzhi"
                                               object:nil];
    [self initMineNavigationBar];
    [self initMineTableView];
}

//通知方法
-(void)modifiy{
    [self.mineTableView reloadData];
}

-(void)initMineNavigationBar{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏"] forBarMetrics:(UIBarMetrics)UIBarMetricsDefault];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, [UIFont fontWithName:@"PingFang SC" size:18], NSFontAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
}

-(void)initMineTableView{
    
    _mineTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height) style:UITableViewStyleGrouped];
    _mineTableView.delegate = self;
    _mineTableView.dataSource = self;
    
    [self.view addSubview:_mineTableView];
    [self initMineListNames];
    [self mockSomethingData];
}

-(void)mockSomethingData{
    self.user = [HPUser sharedHPUser];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _user.name = @"我是小明啊";
        _user.ID = @"04143137";
        _user.professional = @"软件1404";
        _user.money = 100;
    });
}

-(void)initMineListNames{
    _mineListNames = @[@"荣誉值",@"我的地址",@"我的好友",@"我的足迹",@"设置"];
}

#pragma mark - Tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;  {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? 1 : [_mineListNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"cell";
    HPMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[HPMTableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:identifier];
    }else{
        //cell中本来就有一个subview，如果是重用cell，则把cell中自己添加的subview清除掉，避免出现重叠问题
        for (UIView *subView in cell.contentView.subviews)
        {
            [subView removeFromSuperview];
        }
    }
    
    //设置cell显示右边的小箭头
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        [cell initMineInfomationCell];
        UIImage *image = [[UIImage alloc] init];
        if (_user.imagePath == NULL) {
            image = [UIImage imageNamed:@"路飞"];//默认为路飞头像
        }
        else{
            image = [UIImage imageWithContentsOfFile:_user.imagePath];
        }
        cell.headImageView.image = image;
        cell.nameLabel.text = _user.name;
        cell.majorLabel.text = _user.professional;
        cell.IDLabel.text = _user.ID;
    }else if (indexPath.section == 1){
        cell.textLabel.text = [_mineListNames objectAtIndex:indexPath.row];
        if (indexPath.row == 0) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld",(long)_user.money];
        }
    }
    
    return cell;
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HPUserViewController *userViewController = [[HPUserViewController alloc] init];
    userViewController.hidesBottomBarWhenPushed = YES;
    HPHonorViewController *honorViewController = [[HPHonorViewController alloc] init];
    honorViewController.hidesBottomBarWhenPushed = YES;
    HPAddressViewController *addressViewController = [[HPAddressViewController alloc] init];
    addressViewController.hidesBottomBarWhenPushed = YES;
    HPLoginViewController *loginViewController = [[HPLoginViewController alloc] init];
    loginViewController.hidesBottomBarWhenPushed = YES;
    
    if (indexPath.section == 0) {
        [self.navigationController pushViewController:userViewController animated:YES];
    }
    
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                [self.navigationController pushViewController:honorViewController animated:YES];
                break;
            case 1:
                [self.navigationController pushViewController:addressViewController animated:YES];
                break;
            case 4:
                [self.navigationController pushViewController:loginViewController animated:YES];
                break;
            default:
                break;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section == 0? 80:44;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changeHeadTongzhi" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changeNameTongzhi" object:nil];
}

@end
