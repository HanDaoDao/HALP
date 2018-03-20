//
//  HPNewAddressTableViewCell.m
//  HALP
//
//  Created by HanZhao on 2018/3/19.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPNewAddressTableViewCell.h"
#import "Masonry.h"

@interface HPNewAddressTableViewCell ()

@end

@implementation HPNewAddressTableViewCell

-(void)setupContactsView{
    _titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_titleLabel];
    
    _textField = [[UITextField alloc] init];
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.contentView addSubview:_textField];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(5);
        make.bottom.equalTo(self.contentView).offset(-5);
        make.left.equalTo(self.contentView).offset(10);
        make.width.mas_equalTo(55);
    }];
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(5);
        make.right.equalTo(self.contentView).offset(-5);
        make.bottom.equalTo(self.contentView).offset(-10);
        make.left.equalTo(_titleLabel.mas_right).offset(10);
    }];
}

-(void)setupAddressView{
    _titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_titleLabel];
    
    _textField = [[UITextField alloc] init];
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.contentView addSubview:_textField];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(5);
        make.bottom.equalTo(self.contentView).offset(-5);
        make.left.equalTo(self.contentView).offset(10);
        make.width.mas_equalTo(95);
    }];
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(5);
        make.right.equalTo(self.contentView).offset(-5);
        make.bottom.equalTo(self.contentView).offset(-5);
        make.left.equalTo(_titleLabel.mas_right).offset(5);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
