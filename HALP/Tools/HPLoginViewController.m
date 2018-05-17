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
#import "SVProgressHUD.h"

@interface HPLoginViewController ()

@property(nonatomic,strong) UILabel *schoolLabel;
@property(nonatomic,strong) UIButton *schoolButton;
@property(nonatomic,strong) UILabel *usernameLabel;
@property(nonatomic,strong) UITextField *nameTextFiled;
@property(nonatomic,strong) UILabel *passwordLabel;
@property(nonatomic,strong) UITextField *passwordTextFiled;
@property(nonatomic,strong) UIButton *loginButton;
@property(nonatomic,strong) NSMutableDictionary* schoolDic;
@property(nonatomic,copy) NSString *nameIDString;
@property(nonatomic,copy) NSString *schoolName;


@end

@implementation HPLoginViewController

//懒加载dataArray
-(NSMutableDictionary *)schoolDic{
    if (!_schoolDic) {
        _schoolDic = [NSMutableDictionary dictionary];
    }
    return _schoolDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    [self findschoolList:^(NSMutableDictionary *dictionary, NSError *error) {
        self.schoolDic = dictionary;
    }];
    [self setupComponent];

}

-(void)setupComponent{
    _schoolLabel = [[UILabel alloc] init];
    _schoolLabel.text = @"学校：";
    _schoolLabel.font = [UIFont fontWithName:@"PingFang SC" size:18];
    
    _schoolButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    _schoolButton.backgroundColor = hpRGBHex(0xF5F5F5);
    _schoolButton.layer.cornerRadius = 5;
    _schoolButton.layer.masksToBounds = YES;
    [_schoolButton setTitle:@"请选择学校" forState:UIControlStateNormal];
    [_schoolButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    [_schoolButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_schoolButton addTarget:self action:@selector(chooseSchool) forControlEvents:(UIControlEventTouchUpInside)];
    
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
    
    [self.view addSubview:_schoolLabel];
    [self.view addSubview:_schoolButton];
    [self.view addSubview:_usernameLabel];
    [self.view addSubview:_passwordLabel];
    [self.view addSubview:_nameTextFiled];
    [self.view addSubview:_passwordTextFiled];
    [self.view addSubview:_loginButton];
    
    [_schoolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(120);
        make.left.mas_equalTo(self.view.mas_left).offset(60);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(40);
    }];
    
    [_schoolButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_schoolLabel.mas_right);
        make.top.mas_equalTo(self.view.mas_top).offset(120);
        make.height.mas_equalTo(40);
        make.right.mas_equalTo(self.view.mas_right).offset(-60);
    }];
    
    [_usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_schoolLabel.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left).offset(60);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(40);
    }];
    
    [_nameTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_usernameLabel.mas_right);
        make.top.mas_equalTo(_schoolLabel.mas_bottom);
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

-(void)chooseSchool{
    UIAlertController *chooseAlert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    for (NSString *nameString in [_schoolDic allKeys]) {
        [chooseAlert addAction:[UIAlertAction actionWithTitle:((void)(@"%@"),nameString)
                                                        style:(UIAlertActionStyleDefault)
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                          self.nameIDString = [_schoolDic objectForKey:nameString];
                                                          _schoolName = nameString;
                                                          [_schoolButton setTitle:_schoolName forState:(UIControlStateNormal)];
                                                      }]];
    }
    [chooseAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:chooseAlert animated:YES completion:nil];
}

-(void)loginAction{
    [SVProgressHUD showWithStatus:@"正在登陆"];
    [SVProgressHUD setBackgroundColor:hpRGBHex(0x808080)];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD dismissWithDelay:1];
    NSString *password = _passwordTextFiled.text;
    NSString *IDString = _nameTextFiled.text;
    _nameIDString = [_nameIDString stringByAppendingString:@"_"];
    _nameIDString = [_nameIDString stringByAppendingString:IDString];

    [BmobUser loginWithUsernameInBackground:_nameIDString password:password block:^(BmobUser *user, NSError *error) {
        if (user) {
            NSLog(@"%@",user);
            //成功之后跳转到我的页面
            UINavigationController *navigationVC = self.navigationController;
            NSNotification *notification = [NSNotification notificationWithName:@"changeNameTongzhi" object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
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
            [SVProgressHUD showSuccessWithStatus:@"用户不存在或密码错误"];
            [SVProgressHUD setBackgroundColor:hpRGBHex(0x808080)];
            [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
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

-(void)findschoolList:(findExpBlock)callBack{
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"Dictionary"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        self.schoolDic = nil;
        if (error) {
            NSLog(@"ERROR");
        }else{
            for (BmobObject *obj in array) {
                if ([[obj objectForKey:@"dicType"] intValue] == 4) {
                    NSString *schoolKey = [obj objectForKey:@"dataName"];
                    NSString *schoolValue = [NSString stringWithFormat:@"%@", [obj objectForKey:@"dataType"]];
                    [self.schoolDic setValue:schoolValue forKey:schoolKey];
                }
            }
        }
        callBack(self.schoolDic,error);
    }];
}

@end
