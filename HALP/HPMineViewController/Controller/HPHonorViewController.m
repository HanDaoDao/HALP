//
//  HPHonorViewController.m
//  HALP
//
//  Created by HanZhao on 2018/3/1.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPHonorViewController.h"

@interface HPHonorViewController ()

@end

@implementation HPHonorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self initFrame];
}

-(void)initFrame{
    _honorImageView = [[UIImageView alloc] init];
    UIImage *honorImage = [UIImage imageNamed:@"四叶草"];
    _honorImageView.image = honorImage;
    [self.view addSubview:_honorImageView];
    
    _honorLabel = [[UILabel alloc] init];
    _honorLabel.text = @"荣誉值";
    _honorLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_honorLabel];
    
    _numberLabel = [[UILabel alloc] init];
    _numberLabel.font = [UIFont fontWithName:@"PingFang SC" size:40];
    _numberLabel.text = @"100";
    _numberLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_numberLabel];
    
    [_honorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(100);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
    }];
    
    [_honorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(_honorImageView.mas_bottom).offset(20);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(_honorLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(40);
    }];
    
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
