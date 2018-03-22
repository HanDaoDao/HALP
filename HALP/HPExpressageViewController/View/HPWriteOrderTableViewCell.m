//
//  HPWriteOrderTableViewCell.m
//  HALP
//
//  Created by HanZhao on 2018/3/20.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPWriteOrderTableViewCell.h"
#import "Masonry.h"
#import <QuartzCore/QuartzCore.h>
#import "headFile.pch"

@interface HPWriteOrderTableViewCell ()

@property(nonatomic,strong) UILabel *remarkLabel;
@property(nonatomic,strong) UITextView *remarkTextView;

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
    _expNumberLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_expNumberLabel];
    
    [_expNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(5);
        make.left.equalTo(self.contentView).offset(60);
        make.width.mas_equalTo(90);
        make.bottom.equalTo(self.contentView).offset(-5);
    }];
    
    _numberTextField = [[UITextField alloc] init];
    [self.contentView addSubview:_numberTextField];
    
    [_numberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.expNumberLabel.mas_right);
        make.top.equalTo(self.contentView).offset(5);
        make.right.equalTo(self.contentView).offset(-80);
        make.bottom.equalTo(self.contentView).offset(-5);
    }];
}

-(void)initRemarkCell{
    _remarkLabel = [[UILabel alloc] init];
    _remarkLabel.text = @"备注:";
    _remarkLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_remarkLabel];
    
    _remarkTextView = [[UITextView alloc] init];
    _remarkTextView.font = [UIFont systemFontOfSize:14.f];
    [self.contentView addSubview:_remarkTextView];
    
    [_remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(60);
        make.top.equalTo(self.contentView).offset(5);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(30);
    }];
    
    [_remarkTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.remarkLabel.mas_right);
        make.top.equalTo(self.contentView).offset(5);
        make.right.equalTo(self.contentView).offset(-60);
        make.bottom.equalTo(self.contentView).offset(-5);
    }];
}

-(void)initMakeSureOrderCell{
    
    self.contentView.backgroundColor = hpRGBHex(0xFFB400);
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

