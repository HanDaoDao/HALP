//
//  HPAdd_addressViewController.m
//  HALP
//
//  Created by HanZhao on 2018/3/19.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPAdd_addressViewController.h"
#import "HPAddress.h"
#import "HPAddressViewController.h"

@interface HPAdd_addressViewController ()

//@property(nonatomic,strong) UITableView *tableView;
//@property(nonatomic,strong) NSArray *contactsArray;
//@property(nonatomic,strong) NSArray *addressArray;
//@property(nonatomic,strong) HPAddress *oneAddress;
@property(nonatomic,strong) UITextView *addressTextView;

@end

@implementation HPAdd_addressViewController

-(void)loadView{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scrollView.alwaysBounceVertical = YES;
    self.view = scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1.0];
    self.navigationController.navigationBar.topItem.title = @" ";
    self.navigationItem.title = @"新增地址";
    
    UIBarButtonItem *saveBarButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:(UIBarButtonItemStyleDone) target:self action:@selector(saveOneAddress)];
    self.navigationItem.rightBarButtonItem = saveBarButton;
    
    _addressTextView = [[UITextView alloc] init];
    _addressTextView.frame = CGRectMake(16, 16, SCREEN_WIDTH - 2 * 16, 92);
    _addressTextView.font = [UIFont systemFontOfSize:16.0];
    [self.view addSubview:_addressTextView];

}

-(void)saveOneAddress{
    NSString *addressString = _addressTextView.text;
    if (addressString.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写地址"];
        [SVProgressHUD setBackgroundColor:hpRGBHex(0x808080)];
        [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
        [SVProgressHUD dismissWithDelay:1.5];
    }else{
        _user.addressList = [_user.addressList arrayByAddingObject:addressString];
        BmobUser *bUser = [BmobUser currentUser];
        [bUser setObject:_user.addressList forKey:@"addr"];
        [bUser updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
                [SVProgressHUD showSuccessWithStatus:@"创建成功"];
                [SVProgressHUD setBackgroundColor:hpRGBHex(0x808080)];
                [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
                [SVProgressHUD dismissWithDelay:1.5];
                NSNotification *notification = [NSNotification notificationWithName:@"appendAddressTongzhi" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                NSLog(@"error %@",[error description]);
            }
        }];
    }
}

@end
