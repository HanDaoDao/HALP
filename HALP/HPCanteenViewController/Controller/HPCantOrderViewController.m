//
//  HPCantOrderViewController.m
//  HALP
//
//  Created by HanZhao on 2018/3/29.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPCantOrderViewController.h"
#import "HPCantPopViewController.h"
#import "ReactiveObjC.h"

@interface HPCantOrderViewController ()<UIPopoverPresentationControllerDelegate>

@property(nonatomic,strong) UIButton *topButton;
@property(nonatomic,strong) HPCantPopViewController *popViewVC;
@property(nonatomic,copy) NSString *chosseCanteenStr;


@end

@implementation HPCantOrderViewController

-(HPCantPopViewController *)popViewVC{
    if(!_popViewVC){
        _popViewVC = [[HPCantPopViewController alloc] init];
    }
    return _popViewVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    [self setupTopButton];
    [self notificationAction];
}

-(void)setupTopButton{
    _topButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_topButton setFrame:CGRectMake(20, 20, 100, 40)];
    [_topButton setTitle:@"旭日苑 " forState:(UIControlStateNormal)];
    [_topButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [_topButton setImage:[UIImage imageNamed:@"下拉"] forState:(UIControlStateNormal)];
    [_topButton addTarget:self action:@selector(ChooseCanteen:) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.titleView = _topButton;
}

-(void)ChooseCanteen:(UIButton *)sender{
    [self popConfig];
    self.popViewVC.popoverPresentationController.sourceView = sender;
    self.popViewVC.popoverPresentationController.sourceRect = sender.bounds;
    [self presentViewController:_popViewVC animated:YES completion:nil];
}

-(void)popConfig{
    self.popViewVC.modalPresentationStyle = UIModalPresentationPopover;
    self.popViewVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    self.popViewVC.popoverPresentationController.backgroundColor = [UIColor whiteColor];
    self.popViewVC.popoverPresentationController.delegate = self;
    self.popViewVC.preferredContentSize = CGSizeMake(120, 120);
}

-(void)notificationAction{
    @weakify(self)
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"chooseCanteenTongZhi" object:nil] subscribeNext:^(NSNotification * notification) {
        @strongify(self)
        self.chosseCanteenStr = notification.userInfo[@"chooseCanteen"];
        [self.topButton setTitle:_chosseCanteenStr forState:(UIControlStateNormal)];
    }];
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller traitCollection:(UITraitCollection *)traitCollection
{
    return UIModalPresentationNone;
}


@end
