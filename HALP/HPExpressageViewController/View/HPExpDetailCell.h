//
//  HPExpDetailCell.h
//  HALP
//
//  Created by HanZhao on 2018/3/27.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HPExpDetailCell : UITableViewCell

@property(nonatomic,strong) UIImageView *headView;          //头像
@property(nonatomic,strong) UIImageView *sexView;           //性别展示View
@property(nonatomic,strong) UILabel *nameLabel;             //姓名
@property(nonatomic,strong) UILabel *hornorLabel;           //专业
@property(nonatomic,strong) UILabel *phoneLabel;            //学号

@property(nonatomic,strong) UILabel *expLabel;                     //快递
@property(nonatomic,strong) UILabel *expDetailLabel;               //快递信息
@property(nonatomic,strong) UIButton *acceptButton;                //接单按钮

-(void)setupHeadCell;
-(void)setupDetailCell;
-(void)acceptCell;

@end
