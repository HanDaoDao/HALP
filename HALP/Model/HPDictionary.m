//
//  HPDictionary.m
//  HALP
//
//  Created by 韩钊 on 2018/4/17.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPDictionary.h"

@implementation HPDictionary

+(void)findAllDictionary{
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"Dictionary"];
    //查找GameScore表的数据
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            //打印playerName
            NSLog(@"obj.dataName = %@", [obj objectForKey:@"dataName"]);
            //打印objectId,createdAt,updatedAt
            NSLog(@"obj.dicType = %@\n", [obj objectForKey:@"dicType"]);
        }
    }];
}

@end
