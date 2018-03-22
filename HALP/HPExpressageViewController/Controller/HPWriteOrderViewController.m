//
//  HPWriteOrderViewController.m
//  HALP
//
//  Created by HanZhao on 2018/3/20.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPWriteOrderViewController.h"
#import "headFile.pch"
#import "HPWriteOrderTableViewCell.h"
#import "HPPopViewViewController.h"
#import "ReactiveObjC.h"
#import "Masonry.h"
#import "HPExpOrder.h"
#import "HPAddressViewController.h"

@interface HPWriteOrderViewController ()<UITableViewDelegate,UITableViewDataSource,UIPopoverPresentationControllerDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) HPPopViewViewController *popViewVC;
@property(nonatomic,copy) NSString *chosseAreaString;
@property(nonatomic,copy) NSArray *array;
@property(nonatomic,strong) HPExpOrder *oneOrder;
@property(nonatomic,strong) UIButton *areaButton;
@property(nonatomic,strong) UITextField *nameTextField;
@property(nonatomic,strong) UITextField *telTextField;
@property(nonatomic,strong) UITextField *numberTextField;
@property(nonatomic,strong) UITextField *markTextField;

@end

@implementation HPWriteOrderViewController

-(NSString *)chosseAreaString{
    if(!_chosseAreaString){
        _chosseAreaString = @"体育场东南角";
    }
    return _chosseAreaString ;
}

-(HPPopViewViewController *)popViewVC{
    if(!_popViewVC){
        _popViewVC = [[HPPopViewViewController alloc] init];
    }
    return _popViewVC;
}

-(void)initArrayList{
    _array = @[@"姓名:",@"电话:",@"取货号:",@"备注:"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self setupView];
    [self chosseAreaString];
    [self notificationAction];
    [self initArrayList];
    
    //添加手势，键盘隐藏
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchesBegan)];
    [self.view addGestureRecognizer:tap];
}

-(void)setupView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.bottom.equalTo(self.view);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? 5 : 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    HPWriteOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[HPWriteOrderTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }else{
        for (UIView *subView in cell.contentView.subviews)
        {
            [subView removeFromSuperview];
        }
    }
    if(indexPath.section == 0){
        if (indexPath.row == 0) {
            [cell initChooseAreaCell];
            [cell.chooseButton setTitle:_chosseAreaString forState:(UIControlStateNormal)];
            [cell.chooseButton addTarget:self action:@selector(ChooseArea:) forControlEvents:(UIControlEventTouchUpInside)];
            self.areaButton = cell.chooseButton;
        }else{
            [cell initExpressNumberCell];
            cell.expNumberLabel.text = _array[indexPath.row - 1];
            switch (indexPath.row) {
                    case 1:
                    self.nameTextField = cell.numberTextField;break;
                    case 2:
                    self.telTextField = cell.numberTextField;break;
                    case 3:
                    self.numberTextField = cell.numberTextField;break;
                    case 4:
                    self.markTextField = cell.numberTextField;break;
                default:
                    break;
            }
        }
    }else if (indexPath.section == 1) {
        [cell initSendToCell];
        [cell.sendToButton addTarget:self action:@selector(sendToWhereAction) forControlEvents:UIControlEventTouchUpInside];
    }
    else{
        [cell initMakeSureOrderCell];
        [cell.makeSureButton addTarget:self action:@selector(makeSureOrderAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return cell;
}

/**
 快递点按钮点击事件
 @param sender 传入的按钮对象
 */
-(void)ChooseArea:(UIButton *)sender{
    [self popConfig];
    self.popViewVC.popoverPresentationController.sourceView = sender;
    self.popViewVC.popoverPresentationController.sourceRect = sender.bounds;
    [self presentViewController:_popViewVC animated:YES completion:nil];
}

-(void)sendToWhereAction{
    HPAddressViewController *addressVC = [[HPAddressViewController alloc] init];
    addressVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addressVC animated:YES];
}

-(void)makeSureOrderAction{
    if (!_oneOrder) {
        if ((self.nameTextField.text.length == 0) || (self.telTextField.text.length == 0) || (self.numberTextField.text.length == 0)){
            [self showDismissWithTitle:NULL message:@"信息不全,请填写完整"];
            return;
        }
        _oneOrder = [[HPExpOrder alloc] init];
        _oneOrder.expArea = self.areaButton.titleLabel.text;
        _oneOrder.name = self.nameTextField.text;
        _oneOrder.tel = self.telTextField.text;
        _oneOrder.expNumber = self.numberTextField.text;
        _oneOrder.expMark = self.markTextField.text;
        NSLog(@"%@",_oneOrder.expMark);
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"生成订单" preferredStyle:(UIAlertControllerStyleAlert)];
    [alert addAction:[UIAlertAction actionWithTitle:@"否" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"是" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:_oneOrder,@"appendOneOrder", nil];
        NSNotification *notification = [NSNotification notificationWithName:@"appendOneOrderTongzhi" object:nil userInfo:dict];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
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

/**
 配置popView
 */
-(void)popConfig{
    self.popViewVC.modalPresentationStyle = UIModalPresentationPopover;
    self.popViewVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    self.popViewVC.popoverPresentationController.backgroundColor = [UIColor whiteColor];
    self.popViewVC.popoverPresentationController.delegate = self;
    self.popViewVC.preferredContentSize = CGSizeMake(120, 160);
}

-(void)notificationAction{
    @weakify(self)
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"chooseAreaTongZhi" object:nil] subscribeNext:^(NSNotification * notification) {
        @strongify(self)
        self.chosseAreaString = notification.userInfo[@"chooseArea"];
        [_tableView reloadData];
    }];
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller traitCollection:(UITraitCollection *)traitCollection
{
    return UIModalPresentationNone;
}

-(void)touchesBegan{
    [self.view endEditing:YES];
}

@end

