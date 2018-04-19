//
//  HPLoginViewController.m
//  HALP
//
//  Created by HanZhao on 2018/3/2.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPLoginViewController.h"
#import "headFile.pch"

@interface HPLoginViewController ()

@property(nonatomic,strong) UILabel *usernameLabel;
@property(nonatomic,strong) UITextField *nameTextFiled;
@property(nonatomic,strong) UILabel *passwordLabel;
@property(nonatomic,strong) UITextField *passwordTextFiled;
@property(nonatomic,strong) UIButton *loginButton;
@property(nonatomic,strong) UIButton *signUpButton;

@end

@implementation HPLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    [self setupComponent];
}

-(void)setupComponent{
    _usernameLabel = [[UILabel alloc] init];
    _usernameLabel.text = @"学号：";
    _usernameLabel.font = [UIFont fontWithName:@"PingFang SC" size:18];
    
    _passwordLabel = [[UILabel alloc] init];
    _passwordLabel.text = @"密码：";
    _passwordLabel.font = [UIFont fontWithName:@"PingFang SC" size:18];
    
    _nameTextFiled = [[UITextField alloc] init];
    _nameTextFiled.font = [UIFont fontWithName:@"PingFang SC" size:18];
    
    _passwordTextFiled = [[UITextField alloc] init];
    _passwordTextFiled.secureTextEntry = true;
    _passwordTextFiled.font = [UIFont fontWithName:@"PingFang SC" size:18];
    
    _loginButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _loginButton.backgroundColor = hpRGBHex(0x87CEFA);
    _loginButton.layer.cornerRadius = 20;
    _loginButton.layer.masksToBounds = YES;
    [_loginButton setTitle:@"登  录" forState:UIControlStateNormal];
    [_loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    _signUpButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _signUpButton.titleLabel.text = @"注册";
    
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view1];
    
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view2];
    
    [self.view addSubview:_usernameLabel];
    [self.view addSubview:_passwordLabel];
    [self.view addSubview:_nameTextFiled];
    [self.view addSubview:_passwordTextFiled];
    [self.view addSubview:_loginButton];
    [self.view addSubview:_signUpButton];
    
    [_usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(120);
        make.left.mas_equalTo(self.view.mas_left).offset(60);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(40);
    }];
    
    [_nameTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_usernameLabel.mas_right);
        make.top.mas_equalTo(self.view.mas_top).offset(120);
        make.height.mas_equalTo(40);
        make.right.mas_equalTo(self.view.mas_right).offset(-60);
    }];
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(60);
        make.top.mas_equalTo(_usernameLabel.mas_bottom);
        make.right.mas_equalTo(self.view.mas_right).offset(-60);
        make.height.mas_equalTo(0.5);
    }];

    [_passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view1.mas_bottom).offset(5);
        make.left.mas_equalTo(self.view.mas_left).offset(60);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(40);
    }];
    
    [_passwordTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_passwordLabel.mas_right);
        make.top.mas_equalTo(view1.mas_bottom).offset(5);
        make.height.mas_equalTo(40);
        make.right.mas_equalTo(self.view.mas_right).offset(-60);
    }];
    
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(60);
        make.top.mas_equalTo(_passwordLabel.mas_bottom);
        make.right.mas_equalTo(self.view.mas_right).offset(-60);
        make.height.mas_equalTo(0.5);
    }];
    
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view2.mas_bottom).offset(30);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(40);
    }];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_nameTextFiled resignFirstResponder];
    [_passwordTextFiled resignFirstResponder];
}

@end
