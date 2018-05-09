//
//  HPOrderTableViewCell.m
//  HALP
//
//  Created by 韩钊 on 2018/5/8.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPOrderTableViewCell.h"
#import "Masonry.h"

@implementation HPOrderTableViewCell

-(void)initOrderCell{
    
    _titleLabel = [[UILabel alloc] init];
//    _titleLabel.backgroundColor = [UIColor redColor];
    _titleLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_titleLabel];
    
    _textField = [[UITextField alloc] init];
//    _textField.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_textField];
    
    _chooseButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    _chooseButton.backgroundColor = [UIColor redColor];
    [_chooseButton setImage:[UIImage imageNamed:@"选择"] forState:(UIControlStateNormal)];
    [self.contentView addSubview:_chooseButton];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(5);
        make.left.equalTo(self.contentView).offset(40);
        make.width.mas_equalTo(90);
        make.bottom.equalTo(self.contentView).offset(-5);
    }];
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right);
        make.top.equalTo(self.contentView).offset(5);
        make.right.equalTo(self.contentView).offset(-60);
        make.bottom.equalTo(self.contentView).offset(-5);
    }];
    
    [_chooseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.textField.mas_right);
        make.top.equalTo(self.contentView).offset(5);
        make.right.equalTo(self.contentView).offset(-20);
        make.bottom.equalTo(self.contentView).offset(-5);
    }];
    
}

-(void)initMakeSureOrderCell{
    self.contentView.backgroundColor = hpRGBHex(0xAFEEEE);//0xFFB400(食堂确认的颜色)
    _makeSureButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_makeSureButton setTitle:@"确      认" forState:(UIControlStateNormal)];
    [_makeSureButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [self.contentView addSubview:_makeSureButton];
    
    [_makeSureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.and.top.bottom.equalTo(self.contentView);
        make.width.equalTo(self.contentView).multipliedBy(0.5);
    }];
}

@end
