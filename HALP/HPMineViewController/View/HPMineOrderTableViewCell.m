//
//  HPMineOrderTableViewCell.m
//  HALP
//
//  Created by 韩钊 on 2018/5/17.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPMineOrderTableViewCell.h"
#import "headFile.pch"

@implementation HPMineOrderTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupMineOrderListView];
    }
    return self;
}

-(void)setupMineOrderListView{
    
    _headImageView = [[UIImageView alloc] init];
//    _headImageView.backgroundColor = [UIColor redColor];
    _headImageView.layer.cornerRadius = 25;
    _headImageView.layer.masksToBounds = YES;
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = [UIFont fontWithName:@"PingFang SC" size:16];
    
    _statusLabel = [[UILabel alloc] init];
    _statusLabel.font = [UIFont fontWithName:@"PingFang SC" size:16];
    
    _honorLabel = [[UILabel alloc] init];
    _honorLabel.font = [UIFont fontWithName:@"PingFang SC" size:20];
    _honorLabel.textColor = hpRGBHex(0xFFA500);
    
    [self.contentView addSubview:_headImageView];
    [self.contentView addSubview:_timeLabel];
    [self.contentView addSubview:_statusLabel];
    [self.contentView addSubview:_honorLabel];
    
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [_honorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImageView.mas_right).offset(5);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.right.equalTo(_honorLabel.mas_left);
        make.height.mas_equalTo(25);
    }];
    
    [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeLabel.mas_bottom).offset(5);
        make.left.equalTo(_headImageView.mas_right).offset(5);
        make.right.equalTo(_honorLabel.mas_left);
        make.bottom.equalTo(self.contentView).offset(-5);
    }];
}

@end
