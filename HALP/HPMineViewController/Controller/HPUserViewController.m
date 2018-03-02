//
//  HPUserViewController.m
//  HALP
//
//  Created by HanZhao on 2018/3/2.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPUserViewController.h"

@interface HPUserViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *userTableView;

@end

@implementation HPUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self initUserTableView];
}

-(void)initUserTableView{
    _userTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    _userTableView.delegate = self;
    _userTableView.dataSource = self;
    [self.view addSubview:_userTableView];
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
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"乔巴"]];
        [imageView setFrame:CGRectMake(0, 0, 40, 40)];
        cell.accessoryView = imageView;
    }
    
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
