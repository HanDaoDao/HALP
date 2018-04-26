//
//  HPSignUpNextViewController.m
//  HALP
//
//  Created by 韩钊 on 2018/4/24.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPSignUpNextViewController.h"
#import "headFile.pch"
#import "BEMCheckBox.h"
#import "HPMineViewController.h"

@interface HPSignUpNextViewController ()<BEMCheckBoxDelegate>

@property(nonatomic,strong) UITextField *stuIDTextField;
@property(nonatomic,strong) UITextField *nickNameTextField;
@property (nonatomic, strong) BEMCheckBoxGroup *checkBoxGroup;
@property (nonatomic, strong) BEMCheckBox *checkBoxBoy;
@property (nonatomic, strong) BEMCheckBox *checkBoxGirl;

@end

@implementation HPSignUpNextViewController

- (BEMCheckBox *)checkBoxBoy {
    if (!_checkBoxBoy) {
        _checkBoxBoy = [[BEMCheckBox alloc] initWithFrame:CGRectZero];
        _checkBoxBoy.onAnimationType = BEMAnimationTypeBounce;
        _checkBoxBoy.offAnimationType = BEMAnimationTypeBounce;
        _checkBoxBoy.animationDuration = 0.3;
        _checkBoxBoy.delegate = self;
    }
    return _checkBoxBoy;
}

- (BEMCheckBox *)checkBoxGirl {
    if (!_checkBoxGirl) {
        _checkBoxGirl = [[BEMCheckBox alloc] initWithFrame:CGRectZero];
        _checkBoxGirl.onAnimationType = BEMAnimationTypeBounce;
        _checkBoxGirl.offAnimationType = BEMAnimationTypeBounce;
        _checkBoxGirl.animationDuration = 0.3;
        _checkBoxGirl.delegate = self;
    }
    return _checkBoxGirl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    [self setupComponent];
    [self setupBEMCheckBoxGroup];
}

-(void)setupComponent{
    UILabel *schoolLabel = [[UILabel alloc] init];
    schoolLabel.text = @"学校：";
    
    UILabel *schoolText = [[UILabel alloc] init];
    schoolText.text = @"西安邮电大学";
    
    UILabel *stuIDLabel = [[UILabel alloc] init];
    stuIDLabel.text = @"学号：";
    
    _stuIDTextField = [[UITextField alloc] init];
    _stuIDTextField.keyboardType = UIKeyboardTypeNumberPad;

    UILabel *nickNameLabel = [[UILabel alloc] init];
    nickNameLabel.text = @"昵称：";
    
    _nickNameTextField = [[UITextField alloc] init];
    
    UILabel *sexLabel = [[UILabel alloc] init];
    sexLabel.text = @"性别：";
    
    UILabel *boyLabel = [[UILabel alloc] init];
    boyLabel.text = @"帅哥";
    UILabel *girlLabel = [[UILabel alloc] init];
    girlLabel.text = @"美女";
    
    UIButton *completeButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    completeButton.backgroundColor = hpRGBHex(0x87CEFA);
    completeButton.layer.cornerRadius = 20;
    completeButton.layer.masksToBounds = YES;
    [completeButton setTitle:@"完   成" forState:UIControlStateNormal];
    [completeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [completeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [completeButton addTarget:self action:@selector(completeAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:completeButton];
    
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view1];
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view2];
    UIView *view3 = [[UIView alloc] init];
    view3.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view3];
    UIView *view4 = [[UIView alloc] init];
    view4.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view4];
    
    [self.view addSubview:schoolLabel];
    [self.view addSubview:schoolText];
    [self.view addSubview:stuIDLabel];
    [self.view addSubview:_stuIDTextField];
    [self.view addSubview:nickNameLabel];
    [self.view addSubview:_nickNameTextField];
    [self.view addSubview:sexLabel];
    [self.view addSubview:self.checkBoxBoy];
    [self.view addSubview:self.checkBoxGirl];
    [self.view addSubview:boyLabel];
    [self.view addSubview:girlLabel];
    [self.view addSubview:completeButton];
    
    [schoolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(120);
        make.left.mas_equalTo(self.view.mas_left).offset(70);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(40);
    }];
    
    [schoolText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(schoolLabel.mas_right);
        make.top.mas_equalTo(self.view.mas_top).offset(120);
        make.height.mas_equalTo(40);
        make.right.mas_equalTo(self.view.mas_right).offset(-70);
    }];
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(70);
        make.top.mas_equalTo(schoolLabel.mas_bottom);
        make.right.mas_equalTo(self.view.mas_right).offset(-70);
        make.height.mas_equalTo(0.5);
    }];
    
    [stuIDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view1.mas_bottom).offset(5);
        make.left.mas_equalTo(self.view.mas_left).offset(70);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(40);
    }];
    
    [_stuIDTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(stuIDLabel.mas_right);
        make.top.mas_equalTo(view1.mas_bottom).offset(5);
        make.height.mas_equalTo(40);
        make.right.mas_equalTo(self.view.mas_right).offset(-70);
    }];
    
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(70);
        make.top.mas_equalTo(stuIDLabel.mas_bottom);
        make.right.mas_equalTo(self.view.mas_right).offset(-70);
        make.height.mas_equalTo(0.5);
    }];
    
    [nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view2.mas_bottom).offset(5);
        make.left.mas_equalTo(self.view.mas_left).offset(70);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(40);
    }];
    
    [_nickNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nickNameLabel.mas_right);
        make.top.mas_equalTo(view2.mas_bottom).offset(5);
        make.height.mas_equalTo(40);
        make.right.mas_equalTo(self.view.mas_right).offset(-70);
    }];
    
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(70);
        make.top.mas_equalTo(nickNameLabel.mas_bottom);
        make.right.mas_equalTo(self.view.mas_right).offset(-70);
        make.height.mas_equalTo(0.5);
    }];
    
    [sexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view3.mas_bottom).offset(5);
        make.left.mas_equalTo(self.view.mas_left).offset(70);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(40);
    }];
    
    [_checkBoxBoy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(view4.mas_bottom).offset(-10);
        make.left.mas_equalTo(sexLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake(21, 21));
    }];
    
    [boyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view3.mas_bottom).offset(5);
        make.left.mas_equalTo(_checkBoxBoy.mas_right).offset(5);
        make.width.and.height.mas_equalTo(40);
    }];
    
    [_checkBoxGirl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(view4.mas_bottom).offset(-10);
        make.left.mas_equalTo(boyLabel.mas_right).offset(20);
        make.size.mas_equalTo(CGSizeMake(21, 21));
    }];
    
    [girlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view3.mas_bottom).offset(5);
        make.left.mas_equalTo(_checkBoxGirl.mas_right).offset(5);
        make.width.and.height.mas_equalTo(40);
    }];
    
    [view4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(70);
        make.top.mas_equalTo(sexLabel.mas_bottom);
        make.right.mas_equalTo(self.view.mas_right).offset(-70);
        make.height.mas_equalTo(0.5);
    }];

    [completeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view4.mas_bottom).offset(30);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(40);
    }];
}

-(void)completeAction{
    NSString *nameIDString = @"11664_";
    NSString *IDString = _stuIDTextField.text;
    nameIDString = [nameIDString stringByAppendingString:IDString];
    NSString *nickNameString = _nickNameTextField.text;
    
    //数据字典关联
    BmobObject *school = [BmobUser objectWithoutDataWithClassName:@"Dictionary" objectId:@"oDNOJJJR"];
    BmobObject *sex = [BmobUser objectWithoutDataWithClassName:@"Dictionary" objectId:@"qx2fEEEM"];
    //添加用户
    BmobUser *bUser = [[BmobUser alloc] init];
    [bUser setUsername:nameIDString];
    [bUser setPassword:@"123456"];
    [bUser setObject:@"15809009005" forKey:@"mobilePhoneNumber"];
    [bUser setObject:IDString forKey:@"stuId"];
    [bUser setObject:nickNameString forKey:@"nickName"];
    [bUser setObject:@100 forKey:@"stuHonor"];
    [bUser setObject:school forKey:@"stuSchool"];
    [bUser setObject:sex forKey:@"sex"];

    [bUser signUpInBackgroundWithBlock:^ (BOOL isSuccessful, NSError *error){
        if (isSuccessful){
            NSLog(@"Sign up successfully");
        } else {
            NSLog(@"%@",error);
        }
    }];
    
    [BmobUser loginWithUsernameInBackground:nameIDString password:@"123456" block:^(BmobUser *user, NSError *error) {
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

- (void)setupBEMCheckBoxGroup {
    NSArray *checkBoxArray = @[self.checkBoxBoy,self.checkBoxGirl];
    self.checkBoxGroup = [BEMCheckBoxGroup groupWithCheckBoxes:checkBoxArray];
    self.checkBoxGroup.selectedCheckBox = self.checkBoxBoy;
    self.checkBoxGroup.mustHaveSelection = YES;
}

#pragma mark - BEMCheckBoxDelegate

- (void)didTapCheckBox:(BEMCheckBox *)checkBox {
    [self.view endEditing:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_stuIDTextField resignFirstResponder];
    [_nickNameTextField resignFirstResponder];
}

@end
