//
//  HPOrderTableViewCell.h
//  HALP
//
//  Created by 韩钊 on 2018/5/8.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HPOrderTableViewCell : UITableViewCell

@property(nonatomic,strong) UIButton *chooseButton;
@property(nonatomic,strong) UITextField *textField;
@property(nonatomic,strong) UITextView *textView;
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UIButton *makeSureButton;

-(void)initOrderCell;
-(void)initMakeSureOrderCell;

@end
