//
//  HPOtherOrderViewController.m
//  HALP
//
//  Created by 韩钊 on 2018/5/8.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPOtherOrderViewController.h"
#import "HPOrderTableViewCell.h"
#import "NSString+JSON.h"
#import "SVProgressHUD.h"
#import "NSDate+Time.h"

static NSString * const kHPOrderTableViewCell = @"kHPOrderTableViewCell";

@interface HPOtherOrderViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,copy) NSArray *array;
@property(nonatomic,copy) NSString *titleString;
@property(nonatomic,copy) NSString *contentString;
@property(nonatomic,copy) NSString *honorString;

@end

@implementation HPOtherOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    [self initArrayList];
    [self setupView];
    
    //添加手势，键盘隐藏
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchesBegan)];
    [self.view addGestureRecognizer:tap];
}

-(void)initArrayList{
    _array = @[@"标题：",@"需求：",@"荣誉值："];
}

-(void)setupView{
    UITableViewController* tvc=[[UITableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self addChildViewController:tvc];
    _tableView=tvc.tableView;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
        
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.bottom.equalTo(self.view);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? _array.count : 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        return 60;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HPOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kHPOrderTableViewCell];
    
    if (cell == nil) {
        cell = [[HPOrderTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:kHPOrderTableViewCell];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }else{
        for (UIView *subView in cell.contentView.subviews)
        {
            [subView removeFromSuperview];
        }
    }
    
    if(indexPath.section == 0){
        [cell initOrderCell];
        cell.titleLabel.text = [_array objectAtIndex:indexPath.row];
        cell.textField.delegate = self;
        cell.textField.tag = indexPath.row;
        
        [cell.textField addTarget:self action:@selector(textFieldWithText:) forControlEvents:UIControlEventEditingChanged];
        switch (indexPath.row) {
            case 0:
                cell.chooseButton.hidden = YES;
                cell.textField.hidden = NO;
                cell.textView.hidden = YES;
                cell.textField.placeholder = @"输入标题";
                cell.textField.text = _titleString;
                break;
            case 1:
                cell.chooseButton.hidden = YES;
                cell.textField.hidden = YES;
                cell.textView.hidden = NO;
                cell.textView.text = _contentString;
                break;
            case 2:
                cell.textField.placeholder = @"您要悬赏的荣誉值";
                cell.textField.hidden = NO;
                cell.textView.hidden = YES;
                cell.textField.keyboardType = UIKeyboardTypeNumberPad;
                cell.chooseButton.hidden = YES;
                cell.textField.text = _honorString;
                break;
            default:
                break;
        }
    }else{
        [cell initMakeSureOrderCell];
        [cell.makeSureButton addTarget:self action:@selector(makeSureOrderAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return cell;
}

- (void)textFieldWithText:(UITextField *)textField
{
    switch (textField.tag) {
        case 0:
            self.titleString = textField.text;break;
        case 1:
            self.contentString = textField.text;break;
        case 2:
            self.honorString = textField.text;break;
    }
}

-(void)makeSureOrderAction{
    BmobUser *user = [BmobUser currentUser];
    if (_titleString == nil || _contentString == nil || _honorString == nil){
        [self showDismissWithTitle:NULL message:@"信息不全,请填写完整"];
        return;
    }
    NSDictionary * dic = @{
                           @"title":_titleString,
                           @"content":_contentString,
                           };
    NSString *stringDic = [NSString dictionaryToJson:dic];
    NSLog(@"WTF.....%@",stringDic);
    
    BmobObject *order = [BmobObject objectWithClassName:@"Order"];
    NSNumber *honorNum = @([_honorString intValue]);
    [order setObject:honorNum forKey:@"orderHonor"];
    [order setObject:stringDic forKey:@"content"];
    
    BmobUser *creator = [BmobUser objectWithoutDataWithClassName:@"_User" objectId:user.objectId];
    [order setObject:creator forKey:@"creator"];
    
    BmobObject *orderSchool = [BmobObject objectWithoutDataWithClassName:@"Dictionary" objectId:@"oDNOJJJR"];
    [order setObject:orderSchool forKey:@"orderSchool"];
    
    BmobObject *orderStatus = [BmobObject objectWithoutDataWithClassName:@"Dictionary" objectId:@"AfQxEEET"];
    [order setObject:orderStatus forKey:@"orderStatus"];
    
    BmobObject *orderType = [BmobObject objectWithoutDataWithClassName:@"Dictionary" objectId:@"lmh2999k"];
    [order setObject:orderType forKey:@"orderType"];
    
    //异步保存
    [order saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            NSLog(@"创建订单成功！！");
            NSLog(@"objectid :%@",order.objectId);
            [SVProgressHUD showSuccessWithStatus:@"创建订单成功"];
            [SVProgressHUD setHelpBackgroudViewAndDismissWithDelay:1.5];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else{
            if (error) {
                NSLog(@"%@",error);
                [SVProgressHUD showErrorWithStatus:@"创建订单失败，重新创建！"];
                [SVProgressHUD setHelpBackgroudViewAndDismissWithDelay:1.5];
            }
        }
    }];
}

-(void)touchesBegan{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)showDismissWithTitle:(NSString *)title message:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:nil];
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(creatAlert:) userInfo:alert repeats:NO];
}

- (void)creatAlert:(NSTimer *)timer{
    UIAlertController * alert = (UIAlertController *)[timer userInfo];
    [alert dismissViewControllerAnimated:YES completion:nil];
    alert = nil;
}

@end
