//
//  HPSignUpViewController.m
//  HALP
//
//  Created by 韩钊 on 2018/4/20.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPSignUpViewController.h"
#import "headFile.pch"

@interface HPSignUpViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong) UITextField *nameTextFiled;
@property(nonatomic,strong) UITextField *passwordTextFiled;
@property(nonatomic,strong) UITextField *phoneTextFiled;
@property(nonatomic,copy) NSArray *schoolArr;


@end

@implementation HPSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];

    [self setupComponent];
    _schoolArr = @[@"西安邮电大学",@"陕西师范大学",@"西安交通大学",@"西安电子科技大学"];
}

-(void)setupComponent{
    UILabel *schoolLabel = [[UILabel alloc] init];
    schoolLabel.text = @"学校：";
    schoolLabel.font = [UIFont fontWithName:@"PingFang SC" size:18];
    [self.view addSubview:schoolLabel];
    
    UIButton *schoolButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    schoolButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [schoolButton setTitle:@"选择学校" forState:(UIControlStateNormal)];
    [schoolButton setTitleColor:hpRGBHex(0xC0C0C0) forState:UIControlStateNormal];
    [schoolButton addTarget:self action:@selector(chooseSchool) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:schoolButton];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"学号：";
    [self.view addSubview:nameLabel];
    
    _nameTextFiled = [[UITextField alloc] init];
    _nameTextFiled.font = [UIFont fontWithName:@"PingFang SC" size:18];
    _nameTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_nameTextFiled];
    
    UILabel *passwordLabel = [[UILabel alloc] init];
    passwordLabel.text = @"密码：";
    [self.view addSubview:passwordLabel];
    
    _passwordTextFiled = [[UITextField alloc] init];
    _passwordTextFiled.font = [UIFont fontWithName:@"PingFang SC" size:18];
    _passwordTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_passwordTextFiled];
    
    UILabel *phoneLabel = [[UILabel alloc] init];
    phoneLabel.text = @"手机号：";
    [self.view addSubview:phoneLabel];
    
    _phoneTextFiled = [[UITextField alloc] init];
    _phoneTextFiled.font = [UIFont fontWithName:@"PingFang SC" size:18];
    [self.view addSubview:_phoneTextFiled];
    
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view1];
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view2];
    UIView *view3 = [[UIView alloc] init];
    view3.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view3];
    
    UIButton *signupButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    signupButton.backgroundColor = hpRGBHex(0x87CEFA);
    signupButton.layer.cornerRadius = 20;
    signupButton.layer.masksToBounds = YES;
    [signupButton setTitle:@"注  册" forState:UIControlStateNormal];
    [signupButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [signupButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [signupButton addTarget:self action:@selector(signupAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:signupButton];
    
    [schoolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(120);
        make.left.mas_equalTo(self.view.mas_left).offset(60);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(40);
    }];

    [schoolButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(schoolLabel.mas_right);
        make.top.mas_equalTo(self.view.mas_top).offset(120);
        make.height.mas_equalTo(40);
        make.right.mas_equalTo(self.view.mas_right).offset(-60);
    }];
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(60);
        make.top.mas_equalTo(schoolLabel.mas_bottom);
        make.right.mas_equalTo(self.view.mas_right).offset(-60);
        make.height.mas_equalTo(0.5);
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view1.mas_bottom).offset(5);
        make.left.mas_equalTo(self.view.mas_left).offset(60);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(40);
    }];
    
    [_nameTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLabel.mas_right);
        make.top.mas_equalTo(view1.mas_bottom).offset(5);
        make.height.mas_equalTo(40);
        make.right.mas_equalTo(self.view.mas_right).offset(-60);
    }];
    
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(60);
        make.top.mas_equalTo(nameLabel.mas_bottom);
        make.right.mas_equalTo(self.view.mas_right).offset(-60);
        make.height.mas_equalTo(0.5);
    }];
    
    [passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view2.mas_bottom).offset(5);
        make.left.mas_equalTo(self.view.mas_left).offset(60);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(40);
    }];
    
    [_passwordTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(passwordLabel.mas_right);
        make.top.mas_equalTo(view2.mas_bottom).offset(5);
        make.height.mas_equalTo(40);
        make.right.mas_equalTo(self.view.mas_right).offset(-60);
    }];
    
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(60);
        make.top.mas_equalTo(passwordLabel.mas_bottom);
        make.right.mas_equalTo(self.view.mas_right).offset(-60);
        make.height.mas_equalTo(0.5);
    }];
    
    [signupButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view3.mas_bottom).offset(30);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(40);
    }];
}

-(void)signupAction{
    NSString *stuID = _nameTextFiled.text;
    NSString *password = _passwordTextFiled.text;
    NSLog(@"===%@,%@",stuID,password);
}

-(void)chooseSchool{
    UIAlertController *alert;
    UIPickerView *pickerView;
    if (!alert) {
        alert = [UIAlertController alertControllerWithTitle:@"选择学校" message:@"\n\n\n\n\n\n\n" preferredStyle:(UIAlertControllerStyleActionSheet)];
        UIAlertAction *complete = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(30, 10, 300, 200)];
        pickerView.delegate = self;
        pickerView.dataSource = self;
        [pickerView selectRow:20 inComponent:0 animated:NO];
        
        [alert.view addSubview:pickerView];
        [alert addAction:complete];
    }
    [self presentViewController:alert animated:YES completion:^{
    }];//通过模态视图模式显示UIAlertController，相当于UIACtionSheet的sh
}

#pragma mark - UIPicker Delegate
//选择器分为几块
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
//选择器有多少行
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_schoolArr count];
}
//每一行显示的内容
-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *schollLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    schollLabel.text = [[NSString alloc] initWithFormat:@"%@",[_schoolArr objectAtIndex:row]];
    schollLabel.textAlignment = NSTextAlignmentCenter;
    return schollLabel;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_nameTextFiled resignFirstResponder];
    [_passwordTextFiled resignFirstResponder];
}

@end
