//
//  HPCanteenViewController.h
//  HALP
//
//  食堂
//
//  Created by HanZhao on 2018/1/11.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPOrder.h"

@interface HPCanteenViewController : UIViewController

typedef void(^findOrderBlock)(NSMutableArray *array, NSError *error);

@end
