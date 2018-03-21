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

@interface HPWriteOrderViewController ()<UITableViewDelegate,UITableViewDataSource,UIPopoverPresentationControllerDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) HPPopViewViewController *popViewVC;
@property(nonatomic,copy) NSString *chosseAreaString;

@end

@implementation HPWriteOrderViewController

-(NSString *)chosseAreaString{
    if(!_chosseAreaString){
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _chosseAreaString = @"体育场东南角";
        });
    }
    return _chosseAreaString ;
}

-(HPPopViewViewController *)popViewVC{
    if(!_popViewVC){
        _popViewVC = [[HPPopViewViewController alloc] init];
    }
    return _popViewVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self setupView];
    [self chosseAreaString];
    [self notificationAction];
}

-(void)setupView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT) style:(UITableViewStyleGrouped)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    HPWriteOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[HPWriteOrderTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }else{
        //cell中本来就有一个subview，如果是重用cell，则把cell中自己添加的subview清除掉，避免出现重叠问题
        for (UIView *subView in cell.contentView.subviews)
        {
            [subView removeFromSuperview];
        }
    }
    
    if (indexPath.row == 0) {
        [cell initChooseAreaCell];
        NSLog(@"%@",_chosseAreaString);
        [cell.chooseButton setTitle:_chosseAreaString forState:(UIControlStateNormal)];
        [cell.chooseButton addTarget:self action:@selector(initChooseArea:) forControlEvents:(UIControlEventTouchUpInside)];
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
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller traitCollection:(UITraitCollection *)traitCollection
{
    return UIModalPresentationNone;
    
}

@end
