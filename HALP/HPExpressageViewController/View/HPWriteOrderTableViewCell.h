//
//  HPWriteOrderTableViewCell.h
//  HALP
//
//  Created by HanZhao on 2018/3/20.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HPWriteOrderTableViewCell : UITableViewCell

@property(nonatomic,strong) UIButton *chooseButton;
@property(nonatomic,strong) UITextField *numberTextField;
@property(nonatomic,strong) UILabel *expNumberLabel;
@property(nonatomic,strong) UILabel *areaLabel;

-(void)initChooseAreaCell;
-(void)initExpressNumberCell;
-(void)initRemarkCell;
-(void)initMakeSureOrderCell;

@end

