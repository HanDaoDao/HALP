//
//  HPUserNameViewController.m
//  HALP
//
//  Created by HanZhao on 2018/3/8.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPUserNameViewController.h"
#import "Masonry.h"
#import "HPUser.h"

@interface HPUserNameViewController ()

@property(nonatomic,strong) UITextField *modifyName;
@property(nonatomic,strong) HPUser *user;

@end

@implementation HPUserNameViewController

-(void)loadView{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scrollView.alwaysBounceVertical = YES;
    self.view = scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.user = [HPUser sharedHPUser];
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1.0];
    UIBarButtonItem *compeleteButton = [[UIBarButtonItem alloc] initWithTitle:@"完成"
                                                                        style:(UIBarButtonItemStylePlain)
                                                                       target:self
                                                                       action:@selector(compeleteAction)];
    self.navigationItem.rightBarButtonItem = compeleteButton;
    _modifyName = [[UITextField alloc] init];
    _modifyName.frame = CGRectMake(16, 16, SCREEN_WIDTH - 2 * 16, 46);
    _modifyName.backgroundColor = [UIColor whiteColor];
    _modifyName.borderStyle = UITextBorderStyleRoundedRect;
    _modifyName.placeholder = @"昵称";
    _modifyName.text = _user.nickName;
    _modifyName.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_modifyName];
    
    //添加手势，键盘隐藏
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchesBegan)];
    [self.view addGestureRecognizer:tap];
}

-(void)compeleteAction{
    [self.navigationController popViewControllerAnimated:YES];
    self.user.nickName = _modifyName.text;
    
    BmobUser *bUser = [BmobUser currentUser];
    [bUser setObject:_modifyName.text forKey:@"nickName"];
    [bUser updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        NSLog(@"error %@",[error description]);
        if(isSuccessful){
            //通知“个人信息”页面的昵称进行修改
            NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:self.modifyName.text,@"modifyName", nil];
            NSNotification *notification = [NSNotification notificationWithName:@"changeNameTongzhi" object:nil userInfo:dict];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        }
    }];
}

-(void)touchesBegan{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
