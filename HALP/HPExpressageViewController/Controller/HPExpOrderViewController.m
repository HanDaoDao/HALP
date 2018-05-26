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
#import "SVProgressHUD+HPHelper.h"
#import "HPUser.h"
#import "headFile.pch"

@interface HPExpOrderViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) HPUser *user;
@property(nonatomic,copy) NSArray *array;
@property(nonatomic,strong) NSMutableArray* expNameArray;
@property(nonatomic,strong) NSMutableArray* expLocationArray;
@property(nonatomic,strong) NSMutableArray* expSizeArray;
@property(nonatomic,strong) NSMutableArray* expAddressArray;
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

//懒加载dataArray
-(NSMutableArray *)expNameArray{
    if (!_expNameArray) {
        _expNameArray = [NSMutableArray array];
    }
    return _expNameArray;
}

-(NSMutableArray *)expLocationArray{
    if (!_expLocationArray) {
        _expLocationArray = [NSMutableArray array];
    }
    return _expLocationArray;
}

-(NSMutableArray *)expSizeArray{
    if (!_expSizeArray) {
        _expSizeArray = [NSMutableArray array];
    }
    return _expSizeArray;
}

-(NSMutableArray *)expAddressArray{
    if (!_expAddressArray) {
        _expAddressArray = [NSMutableArray array];
    }
    return _expAddressArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.user = [HPUser sharedHPUser];
    [_user initUser];

    [self initArrayList];
    [self setupView];
    //添加手势，键盘隐藏
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchesBegan)];
    [self.view addGestureRecognizer:tap];
}

-(void)initArrayList{
    _array = @[@"快递公司：",@"快递点：",@"包裹尺寸：",@"收件人：",@"取件号：",@"送 至：",@"备 注：",@"荣誉值："];
    [self findExpressNameList:^(NSMutableArray *array, NSError *error) {
        self.expNameArray = array;
    }];
    [self findExpressLocationList:^(NSMutableArray *array, NSError *error) {
        self.expLocationArray = array;
    }];
    [self findExpressSizeList:^(NSMutableArray *array, NSError *error) {
        self.expSizeArray = array;
    }];
    
    self.expAddressArray = _user.addressList;
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
                cell.textField.placeholder = @"快递属于哪个公司";
                cell.textField.text = _companyString;
                [cell.chooseButton addTarget:self action:@selector(chooseButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 1:
                cell.chooseButton.hidden = NO;
                cell.chooseButton.tag = 1;
                cell.textField.placeholder = @"在哪里取";
                cell.textField.text = _loactionString;
                [cell.chooseButton addTarget:self action:@selector(chooseButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 2:
                cell.textField.placeholder = @"包裹多大";
                cell.chooseButton.hidden = NO;
                cell.chooseButton.tag = 2;
                cell.textField.text = _sizeString;
                [cell.chooseButton addTarget:self action:@selector(chooseButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 3:
                cell.textField.placeholder = @"快递收件人";
                cell.chooseButton.hidden = YES;
                cell.textField.text = _receiverString;
                break;
            case 4:
                cell.textField.placeholder = @"取件号(接单后显示)";
                cell.chooseButton.hidden = YES;
                cell.textField.text = _numberString;
                break;
            case 5:
                cell.textField.placeholder = @"快递送到哪";
                cell.chooseButton.hidden = NO;
                cell.chooseButton.tag = 5;
                cell.textField.text = _sendToString;
                [cell.chooseButton addTarget:self action:@selector(chooseButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 6:
                cell.textField.placeholder = @"例：易燃，易爆";
                cell.chooseButton.hidden = YES;
                cell.textField.text = _remarkString;
                break;
            case 7:
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

-(void)chooseButtonAction:(UIButton *)sender{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    switch (sender.tag) {
        case 0:
            for (int i = 0; i < _expNameArray.count; i++) {
                [alert addAction:[UIAlertAction actionWithTitle:((void)(@"%@"),[_expNameArray objectAtIndex:i])
                                                          style:(UIAlertActionStyleDefault)
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            _companyString = [_expNameArray objectAtIndex:i];
                                                            [self.tableView reloadData];
                                                        }]];
            }
            break;
        case 1:
            for (int i = 0; i < _expLocationArray.count; i++) {
                [alert addAction:[UIAlertAction actionWithTitle:((void)(@"%@"),[_expLocationArray objectAtIndex:i])
                                                          style:(UIAlertActionStyleDefault)
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            _loactionString = [_expLocationArray objectAtIndex:i];
                                                            [self.tableView reloadData];
                                                        }]];
            }
            break;
        case 2:
            for (int i = 0; i < _expSizeArray.count; i++) {
                [alert addAction:[UIAlertAction actionWithTitle:((void)(@"%@"),[_expSizeArray objectAtIndex:i])
                                                          style:(UIAlertActionStyleDefault)
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            _sizeString = [_expSizeArray objectAtIndex:i];
                                                            [self.tableView reloadData];
                                                        }]];
            }
            break;
        case 5:
            for (int i = 0; i < _expAddressArray.count; i++) {
                [alert addAction:[UIAlertAction actionWithTitle:((void)(@"%@"),[_expAddressArray objectAtIndex:i])
                                                          style:(UIAlertActionStyleDefault)
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            _sendToString = [_expAddressArray objectAtIndex:i];
                                                            [self.tableView reloadData];
                                                        }]];
            }
            break;
        default:
            break;
    }
    [alert addAction:[UIAlertAction actionWithTitle:@"取消"
                                              style:(UIAlertActionStyleCancel)
                                            handler:^(UIAlertAction * _Nonnull action) {
                                            }]];
    
    
    [self presentViewController:alert animated:YES completion:nil];

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

-(void)findExpressNameList:(findExpBlock)callBack{
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"Express"];
    [bquery includeKey:@"expSchool"];
    
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        self.expNameArray = nil;
        if (error) {
            NSLog(@"ERROR");
        }else{
            for (BmobObject *obj in array) {
                if ([[[obj objectForKey:@"expSchool"] objectForKey:@"dataType"] intValue] == 11664) {
                    NSString *addName = [obj objectForKey:@"expName"];
                    [self.expNameArray addObject:addName];
                }
            }
        }
        callBack(self.expNameArray,error);
    }];
}

-(void)findExpressLocationList:(findExpBlock)callBack{
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"Express"];
    [bquery includeKey:@"expSchool"];
    
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        self.expLocationArray = nil;
        if (error) {
            NSLog(@"ERROR");
        }else{
            for (BmobObject *obj in array) {
                if ([[[obj objectForKey:@"expSchool"] objectForKey:@"dataType"] intValue] == 11664) {
                    NSString *addName = [obj objectForKey:@"location"];
                    [self.expLocationArray addObject:addName];
                }
            }
        }
        callBack(self.expLocationArray,error);
    }];
}

-(void)findExpressSizeList:(findExpBlock)callBack{
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"Dictionary"];
    
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        self.expSizeArray = nil;
        if (error) {
            NSLog(@"ERROR");
        }else{
            for (BmobObject *obj in array) {
                if ([[obj objectForKey:@"dicType"] intValue] == 5) {
                    NSString *addName = [obj objectForKey:@"dataName"];
                    [self.expSizeArray addObject:addName];
                }
            }
        }
        callBack(self.expSizeArray,error);
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
