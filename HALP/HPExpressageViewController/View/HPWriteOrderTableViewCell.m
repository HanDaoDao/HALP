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

@property(nonatomic,strong) UIButton *chooseButton;
@property(nonatomic,strong) UILabel *areaLabel;

@end

@implementation HPWriteOrderTableViewCell

-(void)initChooseAreaCell{
    _chooseButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _chooseButton.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_chooseButton];
    
    _areaLabel = [[UILabel alloc] init];
    _areaLabel.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_areaLabel];
    
    [_chooseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(-5);
        make.left.equalTo(self.contentView).offset(20);
        make.width.mas_equalTo(30);
        make.bottom.equalTo(self.contentView).offset(-5);
    }];
    
    [_areaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.chooseButton.mas_right).offset(10);
        make.top.equalTo(self.contentView).offset(5);
        make.right.equalTo(self.contentView).offset(-10);
        make.bottom.equalTo(self.contentView).offset(-5);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
