//
//  HPCantOrderViewController.m
//  HALP
//
//  Created by HanZhao on 2018/3/29.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPCantOrderViewController.h"

@interface HPCantOrderViewController ()

@property(nonatomic,strong) UIButton *topButton;

@end

@implementation HPCantOrderViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.topItem.title = @" ";

    [self setupTopButton];
}

-(void)setupTopButton{
    _topButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_topButton setFrame:CGRectMake(20, 20, 100, 40)];
    [_topButton setTitle:@"旭日苑 " forState:(UIControlStateNormal)];
    [_topButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [_topButton setImage:[UIImage imageNamed:@"下拉"] forState:(UIControlStateNormal)];
    self.navigationItem.titleView = _topButton;
}


@end
