//
//  HPOrderDetailCell.m
//  HALP
//
//  Created by HanZhao on 2018/3/27.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPOrderDetailCell.h"
#import "Masonry.h"

@implementation HPOrderDetailCell

-(UIImageView *)headView{
    if (!_headView) {
        _headView = [[UIImageView alloc] init];
        _headView.layer.cornerRadius = 25;
        _headView.layer.masksToBounds = YES;
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
//        _nameLabel.backgroundColor = [UIColor redColor];
        _nameLabel.font = [UIFont fontWithName:@"PingFang SC" size:20];
    }
    return _nameLabel;
}

-(UILabel *)hornorLabel{
    if (!_hornorLabel) {
        _hornorLabel = [[UILabel alloc] init];
        _hornorLabel.text = @"悬赏：10";
        _hornorLabel.textColor = hpRGBHex(0xFFA500);
//        _hornorLabel.backgroundColor = [UIColor yellowColor];
        _hornorLabel.font = [UIFont fontWithName:@"PingFang SC" size:24];
    }
    return _hornorLabel;
}

-(UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc] init];
//        _phoneLabel.backgroundColor = [UIColor redColor];
        _phoneLabel.font = [UIFont fontWithName:@"PingFang SC" size:16];
    }
    return _phoneLabel;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentRight;
        _titleLabel.font = [UIFont fontWithName:@"PingFang SC" size:16];
    }
    return _titleLabel;
}

-(UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        _detailLabel.font = [UIFont fontWithName:@"PingFang SC" size:16];
    }
    return _detailLabel;
}

-(UITextView *)detailTextView{
    if (!_detailTextView) {
        _detailTextView = [[UITextView alloc] init];
        _detailTextView.textAlignment = NSTextAlignmentLeft;
        _detailTextView.editable = NO;
        _detailTextView.font = [UIFont fontWithName:@"PingFang SC" size:16];
    }
    return _detailTextView;
}

-(void)setupHeadCell{
    [self.contentView addSubview:self.headView];
    [self.contentView addSubview:self.sexView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.hornorLabel];
    [self.contentView addSubview:self.phoneLabel];
    
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
        make.size.mas_equalTo(CGSizeMake(120, 40));
    }];
    
    [_hornorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(15);
        make.top.equalTo(self.contentView.mas_top).offset(20);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.height.mas_equalTo(50);
    }];
    
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom);
        make.left.equalTo(self.nameLabel.mas_left);
        make.height.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(120, 20));
    }];
    
}

-(void)setupDetailCell{
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailTextView];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.top.equalTo(self.contentView);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(80);
    }];
    
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(10);
        make.top.and.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-20);
    }];
    
    [_detailTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(5);
        make.top.and.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-20);
    }];
}

-(void)acceptCell{
    _acceptButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    _acceptButton.backgroundColor = hpRGBHex(0xAFEEEE);
    [_acceptButton setTitle:@"确   认   接   单" forState:(UIControlStateNormal)];
    [_acceptButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [self.contentView addSubview:_acceptButton];

    [_acceptButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.and.top.and.bottom.equalTo(self.contentView);
        make.width.equalTo(self.contentView);
    }];
}

-(void)cancelAndCompleteCell{
    _cancelButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    _cancelButton.backgroundColor = hpRGBHex(0xFF7F50);
    [_cancelButton setTitle:@"取   消   接   单" forState:(UIControlStateNormal)];
    [_cancelButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [self.contentView addSubview:_cancelButton];
    
    _completeButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    _completeButton.backgroundColor = hpRGBHex(0xAFEEEE);
    [_completeButton setTitle:@"订   单   完   成" forState:(UIControlStateNormal)];
    [_completeButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [self.contentView addSubview:_completeButton];
    
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(self.contentView);
        make.width.equalTo(self.contentView);
        make.height.mas_equalTo(40);
    }];
    
    [_completeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.top.equalTo(_cancelButton.mas_bottom).offset(5);
        make.width.equalTo(self.contentView);
        make.height.mas_equalTo(40);
    }];
}
@end
