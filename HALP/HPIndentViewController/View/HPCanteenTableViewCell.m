//
//  HPCanteenTableViewCell.m
//  HALP
//
//  Created by HanZhao on 2018/3/13.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPCanteenTableViewCell.h"
#import "Masonry.h"

@interface HPCanteenTableViewCell ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation HPCanteenTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
