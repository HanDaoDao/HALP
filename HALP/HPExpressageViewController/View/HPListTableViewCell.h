//
//  HPListTableViewCell.h
//  HALP
//
//  Created by HanZhao on 2018/3/15.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HPListTableViewCell : UITableViewCell

@property(nonatomic,strong) UIView *HPbackgroundView;         //背景阴影
//@property(nonatomic,strong) UIView *HPbackgroundView;         //背景阴影
@property(nonatomic,strong) UIImageView *headView;          //头像
@property(nonatomic,strong) UIImageView *sexView;           //性别展示View
@property(nonatomic,strong) UILabel *nameLabel;             //姓名
@property(nonatomic,strong) UILabel *honorLabel;            //荣誉
@property(nonatomic,strong) UILabel *labelOne;            
@property(nonatomic,strong) UILabel *labelTwo;
@property(nonatomic,strong) UILabel *labelThree;

@end
