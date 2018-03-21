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

@property(nonatomic,strong) UILabel *areaLabel;

@end

@implementation HPWriteOrderTableViewCell

-(void)initChooseAreaCell{
    
    _areaLabel = [[UILabel alloc] init];
//    _areaLabel.backgroundColor = [UIColor yellowColor];
    _areaLabel.text = @"快递点:";
    _areaLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_areaLabel];

    _chooseButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    _chooseButton.backgroundColor = [UIColor redColor];
    [_chooseButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
