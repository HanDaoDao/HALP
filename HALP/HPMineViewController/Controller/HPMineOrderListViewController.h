//
//  HPMineOrderListViewController.h
//  HALP
//
//  Created by 韩钊 on 2018/5/17.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HPMineOrderListViewController : UIViewController

typedef void(^findOrderBlock)(NSMutableArray *array, NSError *error);

@property(nonatomic,assign) Boolean isCreator;

@end