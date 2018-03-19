//
//  HPNewAddressTableViewCell.h
//  HALP
//
//  Created by HanZhao on 2018/3/19.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HPNewAddressTableViewCell : UITableViewCell

@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UITextField *textField;

-(void)setupContactsView;
-(void)setupAddressView;

@end
