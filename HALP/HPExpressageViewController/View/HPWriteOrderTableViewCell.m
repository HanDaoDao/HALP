//
//  HPWriteOrderTableViewCell.m
//  HALP
//
//  Created by HanZhao on 2018/3/20.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPWriteOrderTableViewCell.h"
#import "Masonry.h"

@interface HPWriteOrderTableViewCell ()

@end

@implementation HPWriteOrderTableViewCell

-(void)initChooseAreaCell{
    
    _areaLabel = [[UILabel alloc] init];
    _areaLabel.text = @"快递点:";
    _areaLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_areaLabel];
    
    _chooseButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_chooseButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [_chooseButton setImage:[UIImage imageNamed:@"选择地点1"] forState:(UIControlStateHighlighted)];
    [_chooseButton setImage:[UIImage imageNamed:@"选择地点"] forState:(UIControlStateNormal)];
    [self.contentView addSubview:_chooseButton];
    
    [_areaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(5);
        make.left.equalTo(self.contentView).offset(60);
        make.width.mas_equalTo(90);
        make.bottom.equalTo(self.contentView).offset(-5);
    }];
    
    [_chooseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.areaLabel.mas_right);
        make.top.equalTo(self.contentView).offset(5);
        make.right.equalTo(self.contentView).offset(-80);
        make.bottom.equalTo(self.contentView).offset(-5);
    }];
}

-(void)initExpressNumberCell{
    _expNumberLabel = [[UILabel alloc] init];
    //    _expNumberLabel.backgroundColor = [UIColor yellowColor];
    _expNumberLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_expNumberLabel];
    
    [_expNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(5);
        make.left.equalTo(self.contentView).offset(60);
        make.width.mas_equalTo(90);
        make.bottom.equalTo(self.contentView).offset(-5);
    }];
    
    _numberTextField = [[UITextField alloc] init];
    //    _numberTextField.backgroundColor = [UIColor redColor];
    [_numberTextField setBorderStyle:(UITextBorderStyleRoundedRect)];
    [self.contentView addSubview:_numberTextField];
    
    [_numberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.expNumberLabel.mas_right);
        make.top.equalTo(self.contentView).offset(5);
        make.right.equalTo(self.contentView).offset(-80);
        make.bottom.equalTo(self.contentView).offset(-5);
    }];
}

@end

