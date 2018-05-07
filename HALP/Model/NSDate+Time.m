//
//  NSDate+Time.m
//  HALP
//
//  Created by 韩钊 on 2018/5/4.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "NSDate+Time.h"

@implementation NSDate (Time)

+(NSDate*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
//    NSString *currentTimeString = [formatter stringFrsomDate:datenow];
    
    NSLog(@"currentTimeString =  %@",datenow);
    
    return datenow;
    
}

@end
