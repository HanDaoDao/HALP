//
//  HPCantPopViewController.m
//  HALP
//
//  Created by HanZhao on 2018/3/30.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPCantPopViewController.h"
#import "headFile.pch"

@interface HPCantPopViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) UITableView *contentTable;
@property(nonatomic,copy) NSArray *listArray;

@end

@implementation HPCantPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatSubView];
}

-(void)creatSubView{
    _listArray = @[@"旭日苑",@"美食广场",@"东升苑"];
    _contentTable = [[UITableView alloc] initWithFrame:self.view.frame style:(UITableViewStylePlain)];
    _contentTable.backgroundColor = [UIColor blackColor];
    _contentTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _contentTable.delegate = self;
    _contentTable.dataSource = self;
    [self.view addSubview:_contentTable];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"PopViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.text = _listArray[indexPath.row];
    cell.backgroundColor = hpRGBHex(0x262832);
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:_listArray[indexPath.row],@"chooseCanteen", nil];
    NSNotification *notification = [NSNotification notificationWithName:@"chooseCanteenTongZhi" object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
