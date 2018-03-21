//
//  HPPopViewViewController.m
//  HALP
//
//  Created by HanZhao on 2018/3/21.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPPopViewViewController.h"

@interface HPPopViewViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *contentTable;
@property(nonatomic,copy) NSArray *listArray;

@end

@implementation HPPopViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatSubView];
}

-(void)creatSubView{
    _listArray = @[@"体育场东南角",@"超市",@"京东小屋",@"天桥底下"];
    _contentTable = [[UITableView alloc] initWithFrame:self.view.frame style:(UITableViewStylePlain)];
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
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:_listArray[indexPath.row],@"chooseArea", nil];
    NSNotification *notification = [NSNotification notificationWithName:@"chooseAreaTongZhi" object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

@end
