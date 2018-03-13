//
//  HPIndentViewController.m
//  HALP
//
//  Created by HanZhao on 2018/1/11.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPIndentViewController.h"
#import "Masonry.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@interface HPIndentViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIButton *liftButton;
@property(nonatomic,strong)UIButton *rightButton;
@property(nonatomic,strong)UIButton *tempButton;
@property(nonatomic,strong)UIScrollView *indentScrollView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UISwipeGestureRecognizer *recognizer;

@end

@implementation HPIndentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏"] forBarMetrics:(UIBarMetrics)UIBarMetricsDefault];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, [UIFont fontWithName:@"PingFang SC" size:18], NSFontAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    //初始化按钮
    [self initButton];
    //初始化ScrollView,TableView
    [self setupChildControllers];
    [self initBackGroundView];
//    [self scrollViewDidEndScrollingAnimation:_homeScrollView];
}

//初始化按钮
-(void)initButton{
    //公告按钮
    _liftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _liftButton.tag = 100;
    _liftButton.selected = YES;
    _tempButton = _liftButton;
    _liftButton.backgroundColor = [UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:1];
    [_liftButton setTitle:@"餐品" forState:UIControlStateNormal];
    [_liftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_liftButton setBackgroundImage:[UIImage imageNamed:@"按钮选中背景"] forState:UIControlStateSelected];
    [self.view addSubview:_liftButton];
    
    //通知按钮
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightButton.tag = 101;
    _rightButton.backgroundColor = [UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:1];
    [_rightButton setTitle:@"快递" forState:UIControlStateNormal];
    [_rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_rightButton setBackgroundImage:[UIImage imageNamed:@"按钮选中背景"] forState:UIControlStateSelected];
    [self.view addSubview:_rightButton];
    
    //添加两个按钮的点击事件
    [_liftButton addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [_rightButton addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //两个按钮的约束
    [_liftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.5);
        make.height.equalTo(self.view.mas_height).multipliedBy(0.06);
    }];
    
    [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.right.equalTo(self.view.mas_right);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.5);
        make.height.equalTo(self.view.mas_height).multipliedBy(0.06);
    }];
}

//初始化ScrollView,TableView
-(void)initBackGroundView{
    
    _indentScrollView = [[UIScrollView alloc] init];
    //设置ScrollView内容展示的大小
    _indentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 2 , 0);
    _indentScrollView.bounces = NO;
    _indentScrollView.showsVerticalScrollIndicator = NO;
    _indentScrollView.pagingEnabled = YES;
    _indentScrollView.delegate = self;
    [self.view addSubview:_indentScrollView];
    
    [_indentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_liftButton.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.width.equalTo(self.view.mas_width);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
}

-(void)setupChildControllers{
    HPCanteenTableViewController *canteenTableVC = [[HPCanteenTableViewController alloc] init];
    [self addChildViewController:canteenTableVC];
    HPExpressageTableViewController *expressageTableVC = [[HPExpressageTableViewController alloc] init];
    [self addChildViewController:expressageTableVC];
}

//按钮点击事件
-(void)buttonSelected:(UIButton *)sender{
    
    if (sender!=_tempButton) {
        sender.selected = YES;
        _tempButton.selected = NO;
        _tempButton =sender;
        [UIView animateWithDuration:0.3 animations:^{
            
            _indentScrollView.contentOffset = CGPointMake((sender.tag-100)*SCREEN_WIDTH, 0);
            [self scrollViewDidEndScrollingAnimation:_indentScrollView];
            
        }];
        
    }
}

#pragma mark - UIScrollerViewDelegate
//scrollview 的协议方法
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / SCREEN_WIDTH;
    NSLog(@"%ld",(long)index);
    UITableViewController *tableVC = self.childViewControllers[index];
    tableVC.tableView.frame = CGRectMake(index * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.indentScrollView addSubview:tableVC.tableView];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self scrollViewDidEndScrollingAnimation:_indentScrollView];
    float sub = _indentScrollView.contentOffset.x/SCREEN_WIDTH;
    
    UIButton * btn = (UIButton * )[self.view viewWithTag:sub+100];
    
    if ( _tempButton != btn) {
        btn.selected = YES;
        _tempButton.selected = NO;
        _tempButton = btn;
        
    }
}

@end
