//
//  SVProgressHUD+HPHelper.m
//  HALP
//
//  Created by 韩钊 on 2018/5/26.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "SVProgressHUD+HPHelper.h"

@implementation SVProgressHUD (HPHelper)

+(void)setHelpBackgroudViewAndDismissWithDelay:(NSTimeInterval)delay {
    [SVProgressHUD setBackgroundColor:hpRGBHex(0x808080)];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD dismissWithDelay:delay];
}

@end
