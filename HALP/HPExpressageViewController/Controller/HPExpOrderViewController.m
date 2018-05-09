//
//  HPExpOrderViewController.m
//  HALP
//
//  Created by 韩钊 on 2018/5/8.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPExpOrderViewController.h"
#import "HPOrderTableViewCell.h"
#import "HPExpOrder.h"
#import "NSString+JSON.h"
#import "SVProgressHUD.h"

@interface HPExpOrderViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,copy) NSArray *array;
@property(nonatomic,copy) NSString *companyString;
@property(nonatomic,copy) NSString *loactionString;
@property(nonatomic,copy) NSString *sizeString;
@property(nonatomic,copy) NSString *receiverString;
@property(nonatomic,copy) NSString *numberString;
@property(nonatomic,copy) NSString *sendToString;
@property(nonatomic,copy) NSString *remarkString;
@property(nonatomic,copy) NSString *honorString;

@end

@implementation HPExpOrderViewController

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
    _array = @[@"快递公司：",@"快递点：",@"包裹尺寸：",@"收件人：",@"取件号：",@"送 至：",@"备 注：",@"荣誉值："];
}

-(void)setupView{
    UITableViewController* tvc=[[UITableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self addChildViewController:tvc];
    _tableView=tvc.tableView;
//    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
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
                cell.textField.placeholder = nil;
                cell.chooseButton.hidden = NO;
                cell.textField.placeholder = @"快递属于哪个公司";
                cell.textField.text = _companyString;
                break;
            case 1:
                cell.chooseButton.hidden = YES;
                cell.textField.placeholder = @"在哪里取";
                cell.textField.text = _loactionString;
                break;
            case 2:
                cell.textField.placeholder = @"包裹多大";
                cell.chooseButton.hidden = NO;
                cell.textField.text = _sizeString;
                break;
            case 3:
                cell.textField.placeholder = @"快递收件人";
                cell.chooseButton.hidden = YES;
                break;
            case 4:
                cell.textField.placeholder = @"取件号(接单后显示)";
                cell.chooseButton.hidden = YES;
                break;
            case 5:
                cell.textField.placeholder = @"快递送到哪";
                cell.chooseButton.hidden = NO;
                break;
            case 6:
                cell.textField.placeholder = @"例：易燃，易爆";
                cell.chooseButton.hidden = YES;
                break;
            case 7:
                cell.textField.placeholder = @"您要悬赏多少荣誉值呢";
                cell.chooseButton.hidden = YES;
                break;
            default:
                [cell.chooseButton addTarget:self action:@selector(chooseButtonAction) forControlEvents:UIControlEventTouchUpInside];
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
            self.companyString = textField.text;break;
        case 1:
            self.loactionString = textField.text;break;
        case 2:
            self.sizeString = textField.text;break;
        case 3:
            self.receiverString = textField.text;break;
        case 4:
            self.numberString = textField.text;break;
        case 5:
            self.sendToString = textField.text;break;
        case 6:
            self.remarkString = textField.text;break;
        case 7:
            self.honorString = textField.text;break;
    }
}

-(void)chooseButtonAction{
    NSLog(@"WTF.....");
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
}

-(void)makeSureOrderAction{
    BmobUser *user = [BmobUser currentUser];
    if (_companyString == nil || _loactionString == nil || _sizeString == nil || _receiverString == nil || _numberString == nil || _sendToString == nil || _honorString == nil){
        [self showDismissWithTitle:NULL message:@"信息不全,请填写完整"];
        return;
    }
    if (_remarkString == nil) {
        _remarkString = @" ";
    }
    NSDictionary * dic = @{
                            @"company":_companyString,
                            @"loaction":_loactionString,
                            @"number":_numberString,
                            @"receiver":_receiverString,
                            @"sendTo":_sendToString,
                            @"size":_sizeString,
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

    BmobObject *orderType = [BmobObject objectWithoutDataWithClassName:@"Dictionary" objectId:@"YHVNIIIb"];
    [order setObject:orderType forKey:@"orderType"];

    //异步保存
    [order saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            NSLog(@"创建订单成功！！");
            NSLog(@"objectid :%@",order.objectId);
            [SVProgressHUD showSuccessWithStatus:@"创建订单成功"];
            [SVProgressHUD setBackgroundColor:hpRGBHex(0x808080)];
            [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
            [SVProgressHUD dismissWithDelay:1.5];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else{
            if (error) {
                NSLog(@"%@",error);
                [SVProgressHUD showErrorWithStatus:@"创建订单失败，重新创建！"];
                [SVProgressHUD setBackgroundColor:hpRGBHex(0x808080)];
                [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
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
