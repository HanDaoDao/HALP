//
//  HPTabBarController.m
//  HALP
//
//  Created by HanZhao on 2018/1/11.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPTabBarController.h"


@interface HPTabBarController ()

@end

@implementation HPTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.tabBar.translucent = NO;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    [self initHPTabBarController];
    
}

-(void)initHPTabBarController{

    HPCanteenViewController *canteenVC = [[HPCanteenViewController alloc] init];
    canteenVC.title = @"食堂";
    UINavigationController *canteenNC = [[UINavigationController alloc] initWithRootViewController:canteenVC];
    
    HPExpressageViewController *experssageVC = [[HPExpressageViewController alloc] init];
    experssageVC.title = @"快递";
    UINavigationController *experssageNC = [[UINavigationController alloc] initWithRootViewController:experssageVC];
    
    HPOtherViewController *intendVC = [[HPOtherViewController alloc] init];
    intendVC.title = @"万能帮";
    UINavigationController *intendNC = [[UINavigationController alloc] initWithRootViewController:intendVC];
    
    HPMineViewController *mineVC = [[HPMineViewController alloc] init];
    mineVC.title = @"我的";
    UINavigationController *mineNC = [[UINavigationController alloc] initWithRootViewController:mineVC];
    
    NSArray *nvcArray = @[canteenNC,experssageNC,intendNC,mineNC];
    self.viewControllers = nvcArray;
    
    UITabBarItem *canteenItem = [[UITabBarItem alloc] initWithTitle:@"食堂" image:[[UIImage imageNamed:@"饮食"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] tag:1];
    [canteenVC.navigationController setTabBarItem:canteenItem];
    
    UITabBarItem *experssageItem = [[UITabBarItem alloc] initWithTitle:@"快递" image:[[UIImage imageNamed:@"快递"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] tag:2];
    [experssageVC.navigationController setTabBarItem:experssageItem];
    
    UITabBarItem *intendItem = [[UITabBarItem alloc] initWithTitle:@"订单" image:[[UIImage imageNamed:@"订单"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] tag:3];
    [intendVC.navigationController setTabBarItem:intendItem];
    
    UITabBarItem *mineItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[[UIImage imageNamed:@"我的"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] tag:4];
    [mineVC.navigationController setTabBarItem:mineItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
