//
//  HPAddressListTableViewCell.m
//  HALP
//
//  Created by HanZhao on 2018/3/19.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPAddressListTableViewCell.h"
#import "Masonry.h"
#import "headFile.pch"

@implementation HPAddressListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    
    return self;
}

-(void)setupView{
    _addressLabel = [[UILabel alloc] init];
//    _addressLabel.backgroundColor = [UIColor redColor];
    _addressLabel.text = @"东区安悦公寓 北区 427";
    _addressLabel.font = [UIFont fontWithName:@"PingFang SC" size:16];
    [self.contentView addSubview:_addressLabel];
    
    _nameLabel = [[UILabel alloc] init];
//    _nameLabel.backgroundColor = [UIColor yellowColor];
    _nameLabel.text = @"韩 同学";
    _nameLabel.font = [UIFont fontWithName:@"PingFang SC" size:14];
    _nameLabel.textColor = hpRGBHex(0x696969);
    [self.contentView addSubview:_nameLabel];
    
    _telLabel = [[UILabel alloc] init];
    _telLabel.text = @"18924674937";
    _telLabel.font = [UIFont fontWithName:@"PingFang SC" size:14];
    _telLabel.textColor = hpRGBHex(0x696969);
    [self.contentView addSubview:_telLabel];
    
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-5);
        make.height.mas_equalTo(30);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView).offset(-5);
        make.top.equalTo(_addressLabel.mas_bottom);
        make.width.mas_equalTo(70);
    }];
    
    [_telLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_right).offset(5);
        make.right.and.bottom.equalTo(self.contentView).offset(-5);
        make.top.equalTo(_addressLabel.mas_bottom);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
