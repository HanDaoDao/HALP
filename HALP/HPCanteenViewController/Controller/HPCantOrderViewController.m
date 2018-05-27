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
#import "HPUser.h"

@interface HPCantOrderViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,copy) NSArray *array;
@property(nonatomic,strong) HPUser *user;
@property(nonatomic,strong) NSMutableDictionary* cantNameAndFloorDic;
@property(nonatomic,strong) NSMutableArray* cantFloorArray;
@property(nonatomic,strong) NSMutableDictionary* cantNameAndWindowDic;
@property(nonatomic,strong) NSMutableArray* cantFoodArray;
@property(nonatomic,strong) NSMutableArray* cantAddressArray;
@property(nonatomic,copy) NSString *canteenString;
@property(nonatomic,copy) NSString *floorString;
@property(nonatomic,copy) NSString *foodString;
@property(nonatomic,copy) NSString *windowString;
@property(nonatomic,copy) NSString *sendToString;
@property(nonatomic,copy) NSString *remarkString;
@property(nonatomic,copy) NSString *honorString;

@end

@implementation HPCantOrderViewController

-(NSMutableDictionary *)cantNameAndFloorDic{
    if (!_cantNameAndFloorDic) {
        _cantNameAndFloorDic = [[NSMutableDictionary alloc] init];
    }
    return _cantNameAndFloorDic;
}

-(NSMutableArray *)cantFloorArray{
    if (!_cantFloorArray) {
        _cantFloorArray = [NSMutableArray array];
    }
    return _cantFloorArray;
}

-(NSMutableDictionary *)cantNameAndWindowDic{
    if (!_cantNameAndWindowDic) {
        _cantNameAndWindowDic = [[NSMutableDictionary alloc] init];
    }
    return _cantNameAndWindowDic;
}

-(NSMutableArray *)cantFoodArray{
    if (!_cantFoodArray) {
        _cantFoodArray = [NSMutableArray array];
    }
    return _cantFoodArray;
}

-(NSMutableArray *)cantAddressArray{
    if (!_cantAddressArray) {
        _cantAddressArray = [NSMutableArray array];
    }
    return _cantAddressArray;
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
    _array = @[@"食堂：",@"楼层：",@"窗口：",@"餐品：",@"送 至：",@"备 注：",@"荣誉值："];
    [self findCanteenNameList:^(NSMutableDictionary *dictionary, NSError *error) {
        if (error) {
            NSLog(@"error = %@",error);
        } else {
            self.cantNameAndFloorDic = dictionary;
        }
    }];
    self.cantAddressArray = _user.addressList;
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
                cell.textField.hidden = NO;
                cell.textView.hidden = YES;
                cell.chooseButton.tag = 0;
                cell.textField.placeholder = @"可以输入亦可以选择";
                [cell.chooseButton addTarget:self action:@selector(chooseButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                cell.textField.text = _canteenString;
                break;
            case 1:
                cell.chooseButton.hidden = NO;
                cell.textField.hidden = NO;
                cell.textView.hidden = YES;
                cell.chooseButton.tag = 1;
                [cell.chooseButton addTarget:self action:@selector(chooseButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                cell.textField.placeholder = @"可以输入亦可以选择";
                cell.textField.text = _floorString;
                break;
            case 2:
                cell.textField.placeholder = @"可以输入亦可以选择";
                cell.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
                cell.chooseButton.hidden = YES;
                cell.textField.hidden = NO;
                cell.textView.hidden = YES;
                cell.chooseButton.tag = 2;
//                [cell.chooseButton addTarget:self action:@selector(chooseButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                cell.textField.text = _windowString;
                break;
            case 3:
                cell.textField.placeholder = @"可以输入亦可以选择";
                cell.chooseButton.hidden = YES;
                cell.textField.hidden = NO;
                cell.textView.hidden = YES;
                cell.chooseButton.tag = 3;
//                [cell.chooseButton addTarget:self action:@selector(chooseButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                cell.textField.text = _foodString;
                break;
            case 4:
                cell.textField.placeholder = @"餐品给您送至哪";
                cell.chooseButton.hidden = NO;
                cell.textField.hidden = NO;
                cell.textView.hidden = YES;
                cell.chooseButton.tag = 4;
                [cell.chooseButton addTarget:self action:@selector(chooseButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                cell.textField.text = _sendToString;
                break;
            case 5:
                cell.textField.placeholder = @"还有什么要求";
                cell.chooseButton.hidden = YES;
                cell.textField.hidden = NO;
                cell.textView.hidden = YES;
                cell.textField.text = _remarkString;
                break;
            case 6:
                cell.textField.placeholder = @"您要悬赏多少荣誉值呢";
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
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    switch (sender.tag) {
        case 0:
            for (NSString *nameString in [_cantNameAndFloorDic allKeys]) {
                [alert addAction:[UIAlertAction actionWithTitle:((void)(@"%@"),nameString)
                                                                style:(UIAlertActionStyleDefault)
                                                              handler:^(UIAlertAction * _Nonnull action) {
                                                                  self.canteenString = nameString;
                                                                  [self.tableView reloadData];
                                                                  int floor = [[_cantNameAndFloorDic objectForKey:_canteenString] intValue];
                                                                  self.cantFloorArray = nil;
                                                                  if (floor) {
                                                                      for (int i = 1; i <= floor; i++) {
                                                                          NSString *floorStr = [NSString stringWithFormat:@"%d",i];
                                                                          [self.cantFloorArray addObject:floorStr];
                                                                      }
                                                                  }else{
                                                                      _cantFloorArray = nil;
                                                                  }
                                                              }]];
            }
            break;
        case 1:
            if (_cantFloorArray) {
                for (int i = 0; i < _cantFloorArray.count; i++) {
                    [alert addAction:[UIAlertAction actionWithTitle:((void)(@"%@"),[_cantFloorArray objectAtIndex:i])
                                                              style:(UIAlertActionStyleDefault)
                                                            handler:^(UIAlertAction * _Nonnull action) {
                                                                _floorString = [_cantFloorArray objectAtIndex:i];
                                                                [self.tableView reloadData];
                                                            }]];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"这个餐厅我也不知道有几层诶"];
                [SVProgressHUD setHelpBackgroudViewAndDismissWithDelay:0.8];
            }
            break;
        case 2:
            break;
        case 4:
            for (int i = 0; i < _cantAddressArray.count; i++) {
                [alert addAction:[UIAlertAction actionWithTitle:((void)(@"%@"),[_cantAddressArray objectAtIndex:i])
                                                          style:(UIAlertActionStyleDefault)
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            _sendToString = [_cantAddressArray objectAtIndex:i];
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

-(void)findCanteenNameList:(findDictionaryBlock)callBack{
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"Canteen"];
    [bquery includeKey:@"canteenSchool"];
    
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        self.cantNameAndFloorDic = nil;
        if (error) {
            NSLog(@"ERROR");
        }else{
            for (BmobObject *obj in array) {
                if ([[[obj objectForKey:@"canteenSchool"] objectForKey:@"dataType"] intValue] == 11664) {
                    NSString *addName = [obj objectForKey:@"canteenName"];
                    NSNumber *floorNum = [obj objectForKey:@"canteenFloor"];
                    [self.cantNameAndFloorDic setValue:floorNum forKey:addName];
                }
            }
        }
        callBack(self.cantNameAndFloorDic,error);
    }];
}

-(BOOL)findCanteenFloorList{
    int floor = [[_cantNameAndFloorDic objectForKey:_canteenString] intValue];
    if (floor) {
        for (int i = 0; i < floor; i++) {
            NSString *floorStr = [NSString stringWithFormat:@"%d",i];
            [_cantFloorArray addObject:floorStr];
        }
        return 1;
    } else {
        return 0;
    }
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
