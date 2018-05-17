//
//  HPMineOrderTableViewCell.h
//  HALP
//
//  Created by 韩钊 on 2018/5/17.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HPMineOrderTableViewCell : UITableViewCell

@property(nonatomic,strong) UIImageView *headImageView;
@property(nonatomic,strong) UILabel *timeLabel;
@property(nonatomic,strong) UILabel *statusLabel;
@property(nonatomic,strong) UILabel *honorLabel;

-(void)setupMineOrderListView;

@end

