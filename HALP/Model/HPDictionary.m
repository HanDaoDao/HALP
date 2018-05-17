//
//  HPDictionary.m
//  HALP
//
//  Created by 韩钊 on 2018/4/17.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPDictionary.h"
#import "headFile.pch"

@implementation HPDictionary

//懒加载dataArray
-(NSMutableArray *)sexList{
    if (!_sexList) {
        _sexList = [NSMutableArray array];
    }
    return _sexList;
}

-(NSMutableArray *)orderTypeList{
    if (!_orderTypeList) {
        _orderTypeList = [NSMutableArray array];
    }
    return _orderTypeList;
}

-(NSMutableArray *)orderStatusList{
    if (!_orderStatusList) {
        _orderStatusList = [NSMutableArray array];
    }
    return _orderStatusList;
}

-(NSMutableArray *)bagTypeList{
    if (!_bagTypeList) {
        _bagTypeList = [NSMutableArray array];
    }
    return _bagTypeList;
}

-(NSMutableDictionary *)schoolList{
    if (!_schoolList) {
        _schoolList = [[NSMutableDictionary alloc] init];
    }
    return _schoolList;
}

+(void)findAllDictionary{
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"Dictionary"];
    bquery.cachePolicy = kBmobCachePolicyNetworkElseCache;
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            //打印playerName
            NSLog(@"obj.dataName = %@", [obj objectForKey:@"dataName"]);
            //打印objectId,createdAt,updatedAt
            NSLog(@"obj.dicType = %@\n", [obj objectForKey:@"dicType"]);
        }
    }];
}

//性别列表

//订单状态列表

//订单类型列表

//学校列表

//包裹大小列表

@end
