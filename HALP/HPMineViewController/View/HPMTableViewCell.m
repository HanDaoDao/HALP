//
//  HPMTableViewCell.m
//  HALP
//
//  Created by HanZhao on 2018/1/16.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPMTableViewCell.h"

@implementation HPMTableViewCell

-(void)initMineInfomationCell{
    
    _headImageView = [[UIImageView alloc] init];
    _headImageView.layer.cornerRadius = 30;
    _headImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_headImageView];
    
    _sexView = [[UIImageView alloc] init];
    _sexView.layer.cornerRadius = 10;
    [self.contentView addSubview:_sexView];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:20];
    [self.contentView addSubview:_nameLabel];
    
    _majorLabel = [[UILabel alloc] init];
    _majorLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    [self.contentView addSubview:_majorLabel];
    
    _IDLabel = [[UILabel alloc] init];
    _IDLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
//    [self.contentView addSubview:_IDLabel];
    
    /**
     布局
     */
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(20);
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.width.height.mas_equalTo(60);
    }];
    
    [_sexView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView.mas_right).offset(5);
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.sexView.mas_right).offset(10);
        make.top.mas_equalTo(self.contentView.mas_top).offset(15);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(30);
    }];
    
    [_majorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(self.sexView.mas_right).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(18);
    }];
    
//    [_IDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(_majorLabel.mas_right).offset(10);
//        make.top.mas_equalTo(_nameLabel.mas_bottom).offset(5);
//        make.right.mas_equalTo(self.contentView.mas_right).offset(-20);
//        make.height.mas_equalTo(18);
//    }];
}

-(void)initUnSignUpMineInfomationCell{
    _headImageView = [[UIImageView alloc] init];
    _headImageView.layer.cornerRadius = 30;
    _headImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_headImageView];
    
    _label = [[UILabel alloc] init];
    _label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:20];
    _label.text = @"登录/注册";
    _label.textColor = hpRGBHex(0x6495ED);
    [self.contentView addSubview:_label];

    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(20);
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.width.height.mas_equalTo(60);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.sexView.mas_right).offset(10);
        make.top.mas_equalTo(self.contentView.mas_top).offset(15);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(30);
    }];
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(20);
        make.left.mas_equalTo(_headImageView.mas_right).offset(20);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(30);
    }];
}
@end
