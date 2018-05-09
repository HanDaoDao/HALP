//
//  HPHonorViewController.m
//  HALP
//
//  Created by HanZhao on 2018/3/1.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPHonorViewController.h"

@interface HPHonorViewController ()

@property(nonatomic,strong) UIImageView *honorImageView;
@property(nonatomic,strong) UILabel *honorLabel;
@property(nonatomic,strong) UILabel *numberLabel;

@end

@implementation HPHonorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];    
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
    _numberLabel.text = self.honorString;
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


@end
