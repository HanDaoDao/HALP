//
//  HPUserViewController.m
//  HALP
//
//  Created by HanZhao on 2018/3/2.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPUserViewController.h"
#import "HPUserNameViewController.h"

@interface HPUserViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *userTableView;
@property(nonatomic,strong) NSArray *userSetterList;

@end

@implementation HPUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self initUserTableView];
    [self initUserSetterList];
}

-(void)initUserSetterList{
    _userSetterList = @[@"头像",@"昵称",@"ID",@"更多"];
}

-(void)initUserTableView{
    _userTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    _userTableView.delegate = self;
    _userTableView.dataSource = self;
    [self.view addSubview:_userTableView];
}

#pragma mark - tableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 80;
    }else{
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HPUserNameViewController *userNameVC = [[HPUserNameViewController alloc] init];
    userNameVC.hidesBottomBarWhenPushed = YES;
    
    if (indexPath.row == 0) {
        
    }
    
    if (indexPath.row == 1) {
        [self.navigationController pushViewController:userNameVC animated:YES];
    }
    
}

#pragma mark - tableView dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 0) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"路飞"]];
        [imageView setFrame:CGRectMake(0, 0, 60, 60)];
        cell.accessoryView = imageView;
    }
    cell.textLabel.text = [_userSetterList objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
