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
    
    UIImage *placeholder = [UIImage imageNamed:@"乔巴"];
    _headImageView = [[UIImageView alloc] init];
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:placeholder];
    [self.contentView addSubview:_headImageView];
    
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(20);
        make.top.mas_equalTo(self.contentView.mas_top).offset(20);
        make.width.height.mas_equalTo(40);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
