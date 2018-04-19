//
//  HPLoginViewController.h
//  HALP
//
//  Created by HanZhao on 2018/3/2.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HPLoginViewController : UIViewController

@property(nonatomic,strong) UILabel *usernameLabel;
@property(nonatomic,strong) UITextField *nameTextFiled;
@property(nonatomic,strong) UILabel *passwordLabel;
@property(nonatomic,strong) UITextField *passwordTextFiled;
@property(nonatomic,strong) UIButton *loginButton;
@property(nonatomic,strong) UIButton *signUpButton;

@end
