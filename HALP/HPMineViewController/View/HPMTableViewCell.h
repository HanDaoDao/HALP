//
//  HPMTableViewCell.h
//  HALP
//
//  Created by HanZhao on 2018/1/16.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDWebImage-umbrella.h"
#import "Masonry.h"

@interface HPMTableViewCell : UITableViewCell

@property(nonatomic,strong) UIImageView *headImageView;
@property(nonatomic,strong) UIImageView *sexView;           
@property(nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,strong) UILabel *majorLabel;
@property(nonatomic,strong) UILabel *IDLabel;

-(void)initMineInfomationCell;
@end
