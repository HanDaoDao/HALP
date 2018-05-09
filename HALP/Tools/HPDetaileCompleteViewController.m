//
//  HPDetaileCompleteViewController.m
//  HALP
//
//  Created by 韩钊 on 2018/5/6.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPDetaileCompleteViewController.h"
#import "Masonry.h"
#import "HPCanteenViewController.h"
#import "HPExpressageViewController.h"
#import "SVProgressHUD.h"
#import "HPOtherViewController.h"

@interface HPDetaileCompleteViewController ()

@property(nonatomic,strong) UILabel *timeLabel;
@property(nonatomic,strong) UIButton *completeButton;

@end

@implementation HPDetaileCompleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    [self setCanteenDetailCompleteView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [SVProgressHUD dismiss];
}

-(void)setCanteenDetailCompleteView{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"完成"];
    [self.view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] init];
//    label.backgroundColor = [UIColor redColor];
    label.text = @"接单时间";
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    _timeLabel = [[UILabel alloc] init];
//    _timeLabel.backgroundColor = [UIColor yellowColor];
    _timeLabel.text = _time;
    [self.view addSubview:_timeLabel];
    
    _completeButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [_completeButton setTitle:@"完成" forState:(UIControlStateNormal)];
    [_completeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _completeButton.titleLabel.font = [UIFont systemFontOfSize:17];
    _completeButton.layer.cornerRadius = 20;
    _completeButton.layer.masksToBounds = YES;
    _completeButton.backgroundColor = hpRGBHex(0xFFD700);
    [_completeButton addTarget:self action:@selector(completeBackAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_completeButton];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(100);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(20);
    }];
    
    [_completeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_timeLabel.mas_bottom).offset(50);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];

}

-(void)completeBackAction{
    //成功之后跳转到我的页面
    UINavigationController *navigationVC = self.navigationController;
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    for (UIViewController *vc in navigationVC.viewControllers) {
        [viewControllers addObject:vc];
        if ([vc isKindOfClass:[HPCanteenViewController class]] || [vc isKindOfClass:[HPExpressageViewController class]] || [vc isKindOfClass:[HPOtherViewController class]]) {
            break;
        }
    }
    [navigationVC setViewControllers:viewControllers animated:YES];
    [navigationVC popViewControllerAnimated:YES];
}

@end
