//
//  HPExpDetailViewController.m
//  HALP
//
//  Created by HanZhao on 2018/3/16.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPExpDetailViewController.h"
#import "Masonry.h"
#import "headFile.pch"
#import "HPExpDetailCell.h"

@interface HPExpDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,copy) NSArray *array;
@property(nonatomic,copy) NSArray* dataArray;           //接受的显示数据

@end

@implementation HPExpDetailViewController

//懒加载dataArray
-(NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self setupView];
    [self initArrayList];
}

-(void)initArrayList{
    _array = @[@"快递信息:",@"备注:",@"快递点:",@"送往:"];
}

-(void)setupView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:(UITableViewStyleGrouped)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return indexPath.section == 0 ? 80 : 50;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 80;
        }
    }
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? 5 : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    HPExpDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    if (cell == nil) {
        cell = [[HPExpDetailCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [cell setupHeadCell];
        }else{
            [cell setupDetailCell];
            cell.expLabel.text = _array[indexPath.row-1];
        }
    }else{
        [cell acceptCell];
    }
    
    
    return cell;
}



@end

