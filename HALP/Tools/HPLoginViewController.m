//
//  HPLoginViewController.m
//  HALP
//
//  Created by HanZhao on 2018/3/2.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPLoginViewController.h"
#import "headFile.pch"
#import "HPSignUpViewController.h"
#import "HPMineViewController.h"

@interface HPLoginViewController ()

@property(nonatomic,strong) UILabel *usernameLabel;
@property(nonatomic,strong) UITextField *nameTextFiled;
@property(nonatomic,strong) UILabel *passwordLabel;
@property(nonatomic,strong) UITextField *passwordTextFiled;
@property(nonatomic,strong) UIButton *loginButton;

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
    _nameTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    _nameTextFiled.font = [UIFont fontWithName:@"PingFang SC" size:18];
    
    _passwordTextFiled = [[UITextField alloc] init];
    _passwordTextFiled.secureTextEntry = true;
    _passwordTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    _passwordTextFiled.font = [UIFont fontWithName:@"PingFang SC" size:18];
    
    _loginButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _loginButton.backgroundColor = hpRGBHex(0x87CEFA);
    _loginButton.layer.cornerRadius = 20;
    _loginButton.layer.masksToBounds = YES;
    [_loginButton setTitle:@"登  录" forState:UIControlStateNormal];
    [_loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_loginButton addTarget:self action:@selector(loginAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIBarButtonItem *signUpButton = [[UIBarButtonItem alloc] initWithTitle:@"注册"
                                                                        style:(UIBarButtonItemStylePlain)
                                                                       target:self
                                                                       action:@selector(signUpAction)];
    self.navigationItem.rightBarButtonItem = signUpButton;
    
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

-(void)loginAction{
    NSString *password = _passwordTextFiled.text;
    NSString *nameIDString = @"11664_";
    NSString *IDString = _nameTextFiled.text;
    nameIDString = [nameIDString stringByAppendingString:IDString];


    [BmobUser loginWithUsernameInBackground:nameIDString password:password block:^(BmobUser *user, NSError *error) {
        if (user) {
            NSLog(@"%@",user);
            //成功之后跳转到我的页面
            UINavigationController *navigationVC = self.navigationController;
            NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
            for (UIViewController *vc in navigationVC.viewControllers) {
                [viewControllers addObject:vc];
                if ([vc isKindOfClass:[HPMineViewController class]]) {
                    break;
                }
            }
            [navigationVC setViewControllers:viewControllers animated:YES];
            [navigationVC popViewControllerAnimated:YES];
        } else {
            NSLog(@"%@",error);
        }
    }];

}

-(void)signUpAction{
    HPSignUpViewController *signupViewController = [[HPSignUpViewController alloc] init];
    [self.navigationController pushViewController:signupViewController animated:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_nameTextFiled resignFirstResponder];
    [_passwordTextFiled resignFirstResponder];
}

@end
