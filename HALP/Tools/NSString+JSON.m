//
//  NSString+JSON.m
//  HALP
//
//  Created by 韩钊 on 2018/4/28.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "NSString+JSON.h"

@implementation NSString (JSON)

+(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString{
    if (JSONString == nil) {
        return nil;
    }
    
    NSData *jsonData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

//字典转json格式字符串：
+(NSString*)dictionaryToJson:(NSDictionary *)dic{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+(NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    //设置格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    //现在时间
    
    NSDate *datenow = [NSDate date];
    
    //将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
}

@end
