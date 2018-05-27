//
//  HPCantOrderViewController.h
//  HALP
//
//  Created by HanZhao on 2018/3/29.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HPCantOrderViewController : UIViewController

typedef void(^findDictionaryBlock)(NSMutableDictionary *dictionary, NSError *error);
typedef void(^findArrayBlock)(NSMutableArray *array, NSError *error);

@end
