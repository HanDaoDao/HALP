//
//  HPCantOrderViewController.m
//  HALP
//
//  Created by HanZhao on 2018/3/29.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPCantOrderViewController.h"
#import "ReactiveObjC.h"
#import "BmobSDK.framework/Headers/Bmob.h"
#import "HPOrderTableViewCell.h"
#import "NSString+JSON.h"
#import "SVProgressHUD.h"
#import "SVProgressHUD+HPHelper.h"

@interface HPCantOrderViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,copy) NSArray *array;
@property(nonatomic,copy) NSString *canteenString;
@property(nonatomic,copy) NSString *floorString;
@property(nonatomic,copy) NSString *foodString;
@property(nonatomic,copy) NSString *windowString;
@property(nonatomic,copy) NSString *sendToString;
@property(nonatomic,copy) NSString *remarkString;
@property(nonatomic,copy) NSString *honorString;


@end

@implementation HPCantOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self initArrayList];
    [self setupView];
    
    //添加手势，键盘隐藏
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchesBegan)];
    [self.view addGestureRecognizer:tap];
}

-(void)initArrayList{
    _array = @[@"食堂：",@"楼层：",@"窗口：",@"餐品：",@"送 至：",@"备 注：",@"荣誉值："];
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
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    HPOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[HPOrderTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
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
                cell.chooseButton.hidden = NO;
                cell.chooseButton.tag = 0;
                cell.textField.placeholder = @"可以输入亦可以选择";
                [cell.chooseButton addTarget:self action:@selector(chooseButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                cell.textField.text = _canteenString;
                break;
            case 1:
                cell.chooseButton.hidden = NO;
                cell.chooseButton.tag = 1;
                [cell.chooseButton addTarget:self action:@selector(chooseButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                cell.textField.placeholder = @"可以输入亦可以选择";
                cell.textField.text = _floorString;
                break;
            case 2:
                cell.textField.placeholder = @"可以输入亦可以选择";
                cell.chooseButton.hidden = NO;
                cell.chooseButton.tag = 2;
                [cell.chooseButton addTarget:self action:@selector(chooseButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                cell.textField.text = _windowString;
                break;
            case 3:
                cell.textField.placeholder = @"可以输入亦可以选择";
                cell.chooseButton.hidden = NO;
                cell.chooseButton.tag = 3;
                [cell.chooseButton addTarget:self action:@selector(chooseButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                cell.textField.text = _foodString;
                break;
            case 4:
                cell.textField.placeholder = @"餐品给您送至哪";
                cell.chooseButton.hidden = NO;
                cell.chooseButton.tag = 4;
                [cell.chooseButton addTarget:self action:@selector(chooseButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                cell.textField.text = _sendToString;
                break;
            case 5:
                cell.textField.placeholder = @"还有什么要求";
                cell.chooseButton.hidden = YES;
                cell.textField.text = _remarkString;
                break;
            case 6:
                cell.textField.placeholder = @"您要悬赏多少荣誉值呢";
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
            self.canteenString = textField.text;break;
        case 1:
            self.floorString = textField.text;break;
        case 2:
            self.windowString = textField.text;break;
        case 3:
            self.foodString = textField.text;break;
        case 4:
            self.sendToString = textField.text;break;
        case 5:
            self.remarkString = textField.text;break;
        case 6:
            self.honorString = textField.text;break;
    }
}

-(void)chooseButtonAction:(UIButton *)sender{
    NSLog(@"WTF.....");
}

-(void)makeSureOrderAction{
    BmobUser *user = [BmobUser currentUser];
    if (_canteenString == nil || _floorString == nil || _windowString == nil || _foodString == nil || _sendToString == nil || _honorString == nil){
        [self showDismissWithTitle:NULL message:@"信息不全,请填写完整"];
        return;
    }
    if (_remarkString == nil) {
        _remarkString = @" ";
    }
    NSDictionary * dic = @{
                           @"canteen":_canteenString,
                           @"floor":_floorString,
                           @"window":_windowString,
                           @"food":_foodString,
                           @"sendTo":_sendToString,
                           @"remark":_remarkString,
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
    
    BmobObject *orderType = [BmobObject objectWithoutDataWithClassName:@"Dictionary" objectId:@"RDWbAAAD"];
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

-(void)touchesBegan{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


@end
