//
//  HPExpDetailCell.m
//  HALP
//
//  Created by HanZhao on 2018/3/27.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPExpDetailCell.h"
#import "Masonry.h"

@implementation HPExpDetailCell

-(UIImageView *)headView{
    if (!_headView) {
        _headView = [[UIImageView alloc] init];
        _headView.layer.cornerRadius = 25;
        _headView.layer.masksToBounds = YES;
        _headView.image = [UIImage imageNamed:@"路飞"];
    }
    return _headView;
}

-(UIImageView *)sexView{
    if (!_sexView) {
        _sexView = [[UIImageView alloc] init];
        _sexView.layer.cornerRadius = 10;
        _sexView.image = [UIImage imageNamed:@"性别男"];
    }
    return _sexView;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"漩涡鸣人";
        _nameLabel.font = [UIFont fontWithName:@"PingFang SC" size:20];
    }
    return _nameLabel;
}

-(UILabel *)professionalLabel{
    if (!_professionalLabel) {
        _professionalLabel = [[UILabel alloc] init];
        _professionalLabel.text = @"软件1404";
        _professionalLabel.font = [UIFont fontWithName:@"PingFang SC" size:16];
    }
    return _professionalLabel;
}

-(UILabel *)IDLabel{
    if (!_IDLabel) {
        _IDLabel = [[UILabel alloc] init];
        _IDLabel.text = @"15991776945";
        _IDLabel.font = [UIFont fontWithName:@"PingFang SC" size:16];
    }
    return _IDLabel;
}

-(UILabel *)expLabel{
    if (!_expLabel) {
        _expLabel = [[UILabel alloc] init];
//        _expLabel.backgroundColor = [UIColor redColor];
        _expLabel.textAlignment = NSTextAlignmentRight;
        _expLabel.font = [UIFont fontWithName:@"PingFang SC" size:16];
    }
    return _expLabel;
}

-(UILabel *)expDetailLabel{
    if (!_expDetailLabel) {
        _expDetailLabel = [[UILabel alloc] init];
//        _expDetailLabel.backgroundColor = [UIColor yellowColor];
        _expDetailLabel.textAlignment = NSTextAlignmentRight;
        _expDetailLabel.font = [UIFont fontWithName:@"PingFang SC" size:16];
    }
    return _expDetailLabel;
}

-(void)setupHeadCell{
    [self.contentView addSubview:self.headView];
    [self.contentView addSubview:self.sexView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.professionalLabel];
    [self.contentView addSubview:self.IDLabel];
    
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [_sexView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headView.mas_right).offset(5);
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sexView.mas_right).offset(15);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(120, 30));
    }];
    
    [_professionalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(15);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.height.mas_equalTo(30);
    }];
    
    [_IDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        make.left.equalTo(self.nameLabel.mas_left);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.height.mas_equalTo(20);
    }];
    
}

-(void)setupDetailCell{
    [self.contentView addSubview:self.expLabel];
    [self.contentView addSubview:self.expDetailLabel];
    
    [_expLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.top.and.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(80);
    }];
    
    [_expDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.expLabel.mas_right).offset(10);
        make.top.and.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-20);
    }];
}

-(void)acceptCell{
    self.contentView.backgroundColor = hpRGBHex(0xAFEEEE);
    _acceptButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_acceptButton setTitle:@"确   认   接   单" forState:(UIControlStateNormal)];
    [_acceptButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [self.contentView addSubview:_acceptButton];
    
    [_acceptButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.and.top.bottom.equalTo(self.contentView);
        make.width.equalTo(self.contentView).multipliedBy(0.5);
    }];
}

@end
