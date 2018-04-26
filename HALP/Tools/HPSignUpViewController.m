//
//  HPSignUpViewController.m
//  HALP
//
//  Created by 韩钊 on 2018/4/20.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPSignUpViewController.h"
#import "headFile.pch"
#import "HPDictionary.h"
#import "HPSignUpNextViewController.h"

@interface HPSignUpViewController ()

@property(nonatomic,strong) UITextField *phoneTextFiled;
@property(nonatomic,strong) UITextField *passwordTextFiled;
@property(nonatomic,copy) NSArray *schoolArr;


@end

@implementation HPSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];

    [self setupComponent];
}

-(void)initSchoolList{

    _schoolArr = @[@"西安邮电大学",@"陕西师范大学",@"西安交通大学",@"西安电子科技大学"];
}

-(void)setupComponent{
    UILabel *phoneLabel = [[UILabel alloc] init];
    phoneLabel.text = @"手机号：";
    [self.view addSubview:phoneLabel];
    
    _phoneTextFiled = [[UITextField alloc] init];
    _phoneTextFiled.font = [UIFont fontWithName:@"PingFang SC" size:18];
    _phoneTextFiled.placeholder = @"请使用学信网账号";
    _phoneTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_phoneTextFiled];
    
    UILabel *passwordLabel = [[UILabel alloc] init];
    passwordLabel.text = @"密    码：";
    [self.view addSubview:passwordLabel];
    
    _passwordTextFiled = [[UITextField alloc] init];
    _passwordTextFiled.font = [UIFont fontWithName:@"PingFang SC" size:18];
    _passwordTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_passwordTextFiled];
    
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view1];
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view2];
    
    UIButton *signupButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    signupButton.backgroundColor = hpRGBHex(0x87CEFA);
    signupButton.layer.cornerRadius = 20;
    signupButton.layer.masksToBounds = YES;
    [signupButton setTitle:@"下一步" forState:UIControlStateNormal];
    [signupButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [signupButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [signupButton addTarget:self action:@selector(signupAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:signupButton];
    
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(120);
        make.left.mas_equalTo(self.view.mas_left).offset(60);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(40);
    }];

    [_phoneTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(phoneLabel.mas_right);
        make.top.mas_equalTo(self.view.mas_top).offset(120);
        make.height.mas_equalTo(40);
        make.right.mas_equalTo(self.view.mas_right).offset(-60);
    }];
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(60);
        make.top.mas_equalTo(phoneLabel.mas_bottom);
        make.right.mas_equalTo(self.view.mas_right).offset(-60);
        make.height.mas_equalTo(0.5);
    }];
    
    [passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view1.mas_bottom).offset(5);
        make.left.mas_equalTo(self.view.mas_left).offset(60);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(40);
    }];
    
    [_passwordTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(passwordLabel.mas_right);
        make.top.mas_equalTo(view1.mas_bottom).offset(5);
        make.height.mas_equalTo(40);
        make.right.mas_equalTo(self.view.mas_right).offset(-60);
    }];
    
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(60);
        make.top.mas_equalTo(passwordLabel.mas_bottom);
        make.right.mas_equalTo(self.view.mas_right).offset(-60);
        make.height.mas_equalTo(0.5);
    }];
    
    [signupButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view2.mas_bottom).offset(30);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(40);
    }];
}

-(void)signupAction{
    NSString *stuID = _phoneTextFiled.text;
    NSString *password = _passwordTextFiled.text;
    NSLog(@"===%@,%@",stuID,password);
    
    HPSignUpNextViewController *nextVC = [[HPSignUpNextViewController alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_phoneTextFiled resignFirstResponder];
    [_passwordTextFiled resignFirstResponder];
}

@end
