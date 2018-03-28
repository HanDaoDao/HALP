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
//        _sexView.backgroundColor = [UIColor yellowColor];
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

-(UILabel *)addressLabel{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.text = @"东升苑 - 安悦北区 427";
        _addressLabel.font = [UIFont fontWithName:@"PingFang SC" size:14];
    }
    return _addressLabel;
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
    [self.contentView addSubview:self.professionalLabel];
    [self.contentView addSubview:self.addressLabel];
    
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
    
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        make.left.equalTo(self.nameLabel.mas_left);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.height.mas_equalTo(20);
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
