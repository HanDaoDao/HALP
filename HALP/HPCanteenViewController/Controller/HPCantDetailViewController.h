//
//  HPCantDetailViewController.h
//  HALP
//
//  Created by HanZhao on 2018/3/29.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPOrder.h"

@interface HPCantDetailViewController : UIViewController

@property(nonatomic,strong) HPOrder* orderDetail;
@property(nonatomic,assign) Boolean isCreator;

@end
