//
//  HPUserNameViewController.m
//  HALP
//
//  Created by HanZhao on 2018/3/8.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPUserNameViewController.h"
#import "Masonry.h"

#define hpRGBHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface HPUserNameViewController ()

@property(nonatomic,strong) UITextField *modifyName;

@end

@implementation HPUserNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1.0];
    
    UIBarButtonItem *compeleteButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:(UIBarButtonItemStylePlain) target:self action:@selector(compeleteAction)];
    self.navigationItem.rightBarButtonItem = compeleteButton;
    
    _modifyName = [[UITextField alloc] init];
    _modifyName.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_modifyName];
    
    [_modifyName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(self.view.mas_top).offset(30);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(40);
    }];
    
}

-(void)compeleteAction{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
