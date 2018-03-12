//
//  HPUserNameViewController.h
//  HALP
//
//  Created by HanZhao on 2018/3/8.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#define hpRGBHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface HPUserNameViewController : UIViewController

@end
