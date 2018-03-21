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

@interface HPWriteOrderViewController ()<UITableViewDelegate,UITableViewDataSource,UIPopoverPresentationControllerDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) HPPopViewViewController *popViewVC;
@property(nonatomic,copy) NSString *chosseAreaString;
@property(nonatomic,copy) NSArray *array;

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
    _array = @[@"姓名:",@"电话:",@"取货号:"];
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
    return section == 0 ? 4 : 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section == 1 ? 80 : 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    HPWriteOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[HPWriteOrderTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }else{
        //cell中本来就有一个subview，如果是重用cell，则把cell中自己添加的subview清除掉，避免出现重叠问题
        for (UIView *subView in cell.contentView.subviews)
        {
            [subView removeFromSuperview];
        }
    }
    if(indexPath.section == 0){
        if (indexPath.row == 3) {
            [cell initChooseAreaCell];
            [cell.chooseButton setTitle:_chosseAreaString forState:(UIControlStateNormal)];
            [cell.chooseButton addTarget:self action:@selector(initChooseArea:) forControlEvents:(UIControlEventTouchUpInside)];
        }else{
            [cell initExpressNumberCell];
            cell.expNumberLabel.text = _array[indexPath.row];
            if(indexPath.row == 1){
                cell.numberTextField.placeholder = @"手机后四位";
            }
        }
    }else if (indexPath.section == 1) {
        [cell initRemarkCell];
    }
    else{
        [cell initMakeSureOrderCell];
    }
    
    return cell;
}

/**
 快递点按钮点击事件
 @param sender 传入的按钮对象
 */
-(void)initChooseArea:(UIButton *)sender{
    [self popConfig];
    self.popViewVC.popoverPresentationController.sourceView = sender;
    self.popViewVC.popoverPresentationController.sourceRect = sender.bounds;
    [self presentViewController:_popViewVC animated:YES completion:nil];
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
    
    //注册键盘通知
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrameNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller traitCollection:(UITraitCollection *)traitCollection
{
    return UIModalPresentationNone;
}

-(void)touchesBegan{
    [self.view endEditing:YES];
}

/**
 键盘弹出隐藏tableview的更新
 
 */
/*
 -(void)keyboardWillChangeFrameNotification:(NSNotification *)notification{
     [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(-100);
         make.bottom.equalTo(self.view.mas_bottom).offset(-100);
     }];
 
     [UIView animateWithDuration:0.25 animations:^{
         [self.tableView layoutIfNeeded];
     }];
 }
 
 - (void)keyboardWillHideNotification:(NSNotification *)notification{
     [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
         make.left.and.right.and.top.bottom.equalTo(self.view);
     }];
 
     [UIView animateWithDuration:0.25 animations:^{
         [self.tableView layoutIfNeeded];
     }];
 }
*/

@end

