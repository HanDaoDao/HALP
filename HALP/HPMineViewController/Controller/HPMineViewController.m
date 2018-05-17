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
#import "headFile.pch"
#import "SVProgressHUD.h"
#import "HPMineOrderListViewController.h"
#import "HPFriendViewController.h"


static NSString * const kHPMineViewCell = @"kHPMineViewCell";

@interface HPMineViewController()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *mineTableView;
@property(nonatomic,copy) NSArray *mineListNames;
@property(nonatomic,copy) NSDictionary *personData;
@property(nonatomic,strong) HPUser *user;
@property(nonatomic,strong) BmobUser *bUser;

@end

@implementation HPMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //获取缓存的用户信息
    _bUser = [BmobUser currentUser];
    self.user = [HPUser sharedHPUser];
    [_user initUser];
 
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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [SVProgressHUD dismiss];
    [self.mineTableView reloadData];
}

//通知方法
-(void)modifiy{
    _bUser = [BmobUser currentUser];
    self.user = [HPUser sharedHPUser];
    [_user initUser];
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
    [self.mineTableView registerClass:[HPMTableViewCell class] forCellReuseIdentifier:kHPMineViewCell];
    [self initMineListNames];

}

-(void)initMineListNames{
    _mineListNames = @[@"荣誉值",@"我的地址",@"我发布的",@"我帮助的",@"我关注的",@"退出登录"];
}

#pragma mark - Tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;  {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? 1 : [_mineListNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    HPMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kHPMineViewCell forIndexPath:indexPath];

    //设置cell显示右边的小箭头
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    if (indexPath.section == 0) {
        UIImage *image = [[UIImage alloc] init];
        _bUser = [BmobUser currentUser];
        if (_bUser) {
            cell.nameLabel.text = _user.nickName;
            cell.majorLabel.text = _user.mobilePhoneNumber;
            cell.nameLabel.hidden = NO;
            cell.majorLabel.hidden = NO;
            cell.label.hidden = YES;
            cell.sexView.hidden = NO;
            [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:_user.icon] placeholderImage:[UIImage imageNamed:@"路飞"]];
            if (_user.sex == 0) {
                cell.sexView.image = [UIImage imageNamed:@"性别男"];
            }
            else
                cell.sexView.image = [UIImage imageNamed:@"性别女"];
        }else{
            cell.label.text = @"登录/注册";
            cell.label.hidden = NO;
            cell.nameLabel.hidden = YES;
            cell.majorLabel.hidden = YES;
            cell.sexView.hidden = YES;
            image = [UIImage imageNamed:@"路飞"];//默认为路飞头像
            cell.headImageView.image = image;
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", _user.stuHonor];
        }
        cell.textLabel.text = [_mineListNames objectAtIndex:indexPath.row];
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
    HPMineOrderListViewController *mineorderListViewController = [[HPMineOrderListViewController alloc] init];
    mineorderListViewController.hidesBottomBarWhenPushed = YES;
    HPFriendViewController *friendVC = [[HPFriendViewController alloc] init];
    friendVC.hidesBottomBarWhenPushed = YES;
    
    if (indexPath.section == 0) {
        if (_bUser) {
            [self.navigationController pushViewController:userViewController animated:YES];
        }else{
            [self.navigationController pushViewController:loginViewController animated:YES];
        }
        
    }
    
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                honorViewController.honorString = [NSString stringWithFormat:@"%@", _user.stuHonor];
                [self.navigationController pushViewController:honorViewController animated:YES];
                break;
            case 1:
                [self.navigationController pushViewController:addressViewController animated:YES];
                break;
            case 2:
                [self.navigationController pushViewController:mineorderListViewController animated:YES];
                break;
            case 3:
                [self.navigationController pushViewController:mineorderListViewController animated:YES];
                break;
            case 4:
                break;
            case 5:
                if (!_bUser) {
                    [SVProgressHUD showSuccessWithStatus:@"已经退出登录"];
                    [SVProgressHUD setBackgroundColor:hpRGBHex(0x808080)];
                    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
                    [SVProgressHUD dismissWithDelay:0.8];
                }else{
                    UIAlertController *logoutAlert = [UIAlertController alertControllerWithTitle:@"是否退出登录" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
                    [logoutAlert addAction:[UIAlertAction actionWithTitle:@"是" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                        [BmobUser logout];
                        [SVProgressHUD showSuccessWithStatus:@"退出登录"];
                        [SVProgressHUD setBackgroundColor:hpRGBHex(0x808080)];
                        [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
                        [SVProgressHUD dismissWithDelay:0.8];
                        [self.mineTableView reloadData];
                    }]];
                    [logoutAlert addAction:[UIAlertAction actionWithTitle:@"否" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
                    }]];
                    [self presentViewController:logoutAlert animated:YES completion:nil];
                }
                break;
            default:
                break;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section == 0? 80:44;
}

@end
