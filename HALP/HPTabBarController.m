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
    [self initHPTabBarController];
    
}

-(void)initHPTabBarController{

    HPCanteenViewController *canteenVC = [[HPCanteenViewController alloc] init];
    canteenVC.title = @"食堂";
    UINavigationController *canteenNC = [[UINavigationController alloc] initWithRootViewController:canteenVC];
    
    HPExpressageViewController *experssageVC = [[HPExpressageViewController alloc] init];
    experssageVC.title = @"快递";
    UINavigationController *experssageNC = [[UINavigationController alloc] initWithRootViewController:experssageVC];
    
    HPIndentViewController *intendVC = [[HPIndentViewController alloc] init];
    intendVC.title = @"订单";
    UINavigationController *intendNC = [[UINavigationController alloc] initWithRootViewController:intendVC];
    
    HPMineViewController *mineVC = [[HPMineViewController alloc] init];
    mineVC.title = @"我的";
    UINavigationController *mineNC = [[UINavigationController alloc] initWithRootViewController:mineVC];
    
    NSArray *nvcArray = @[canteenNC,experssageNC,intendNC,mineNC];
    self.viewControllers = nvcArray;
    
    UITabBarItem *canteenItem = [[UITabBarItem alloc] initWithTitle:@"食堂" image:[[UIImage imageNamed:@"饮食"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] tag:1];
    [canteenVC.navigationController setTabBarItem:canteenItem];
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