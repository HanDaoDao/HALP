//
//  NSString+JSON.h
//  HALP
//
//  Created by 韩钊 on 2018/4/28.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JSON)

+(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString;

@end
