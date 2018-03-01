//
//  HPMineViewController.m
//  HALP
//
//  Created by HanZhao on 2018/1/11.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPMineViewController.h"
#import "HPHonorViewController.h"

@interface HPMineViewController()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *mineTableView;
@property(nonatomic,copy) NSArray *mineListNames;
@property(nonatomic,copy) NSDictionary *personData;

@end

@implementation HPMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initMineNavigationBar];
    [self initMineTableView];
    [self initMineListNames];
    [self mockSomethingData];
}

-(void)mockSomethingData{
    _personData = [[NSDictionary alloc] init];
    _personData = @{@"name":@"叨叨",
                    @"major":@"软件1404",};
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
}

-(void)initMineListNames{
    _mineListNames = @[@"荣誉值",@"好友",@"历史",@"设置"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;  {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? 1 : [_mineListNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *indentifier = @"cell";
    HPMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    
    if (cell == nil) {
        cell = [[HPMTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:indentifier];
    }
    
    if (indexPath.section == 0) {
        [cell initMineInfomationCell];
        cell.nameLabel.text = [_personData objectForKey:@"name"];
        cell.majorLabel.text = [_personData objectForKey:@"major"];
    }
    else if (indexPath.section == 1){
        cell.textLabel.text = [_mineListNames objectAtIndex:indexPath.row];
    }
    
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HPHonorViewController *honorViewController = [[HPHonorViewController alloc] init];
    honorViewController.hidesBottomBarWhenPushed = YES;
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [self.navigationController pushViewController:honorViewController animated:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section == 0? 80:44;
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
