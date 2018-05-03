//
//  HPOtherViewController.m
//  HALP
//
//  Created by 韩钊 on 2018/5/3.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPOtherViewController.h"

@interface HPOtherViewController ()

@end

@implementation HPOtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏"] forBarMetrics:(UIBarMetrics)UIBarMetricsDefault];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, [UIFont fontWithName:@"PingFang SC" size:18], NSFontAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
}

@end
