//
//  HPListTableViewCell.m
//  HALP
//
//  Created by HanZhao on 2018/3/15.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPListTableViewCell.h"
#import "Masonry.h"

@interface HPListTableViewCell ()

@end

@implementation HPListTableViewCell

-(UIView *)whiteBackgroudView{
    if (_whiteBackgroudView) {
        _whiteBackgroudView = [[UIView alloc] init];
        _whiteBackgroudView.backgroundColor = [UIColor whiteColor];
    }
    return _whiteBackgroudView;
}

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
    }
    return _sexView;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont fontWithName:@"PingFang SC" size:18];
    }
    return _nameLabel;
}

-(UILabel *)honorLabel{
    if (!_honorLabel) {
        _honorLabel = [[UILabel alloc] init];
        _honorLabel.textColor = hpRGBHex(0xFFA500);
        _honorLabel.font = [UIFont fontWithName:@"PingFang SC" size:18];
    }
    return _honorLabel;
}

-(UILabel *)labelOne{
    if (!_labelOne) {
        _labelOne = [[UILabel alloc] init];
        _labelOne.font = [UIFont fontWithName:@"PingFang SC" size:14];
    }
    return _labelOne;
}

-(UILabel *)labelTwo{
    if (!_labelTwo) {
        _labelTwo = [[UILabel alloc] init];
        _labelTwo.font = [UIFont fontWithName:@"PingFang SC" size:14];
    }
    return _labelTwo;
}

-(UILabel *)labelThree{
    if (!_labelThree) {
        _labelThree = [[UILabel alloc] init];
        _labelThree.font = [UIFont fontWithName:@"PingFang SC" size:14];
    }
    return _labelThree;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupCell];
    }    
    return self;
}

-(void)setupCell{
    [self.contentView addSubview:self.headView];
    [self.contentView addSubview:self.sexView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.labelOne];
    [self.contentView addSubview:self.labelTwo];
    [self.contentView addSubview:self.labelThree];
    [self.contentView addSubview:self.honorLabel];
    
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
    
    [_honorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-15);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [_labelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
        make.left.equalTo(self.nameLabel.mas_left);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.height.mas_equalTo(27);
    }];
    
    [_labelTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labelOne.mas_bottom);
        make.left.equalTo(self.nameLabel.mas_left);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.height.mas_equalTo(27);
    }];
    
    [_labelThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labelTwo.mas_bottom);
        make.left.equalTo(self.nameLabel.mas_left);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.height.mas_equalTo(27);
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
