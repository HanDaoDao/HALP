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
-(NSArray *)sexList{
    if (!_sexList) {
        _sexList = [NSMutableArray array];
    }
    return _sexList;
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

//查找出性别列表
-(void)findSexListWithCallBack:(findBlock)callBack{
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"Dictionary"];
    bquery.cachePolicy = kBmobCachePolicyNetworkElseCache;
    @weakify(self)
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        @strongify(self)
        for (BmobObject *obj in array) {
            if ([[obj objectForKey:@"dicType"] intValue] == 1) {
                [self.sexList addObject:[obj objectForKey:@"dataName"]];
            }
        }
        callBack(self.sexList,error);
    }];
}

//订单状态列表
-(void)findorderStatusListWithCallBack:(findBlock)callBack{
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"Dictionary"];
    bquery.cachePolicy = kBmobCachePolicyNetworkElseCache;
    @weakify(self)
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        @strongify(self)
        for (BmobObject *obj in array) {
            if ([[obj objectForKey:@"dicType"] intValue] == 2) {
                [self.orderStatusList addObject:[obj objectForKey:@"dataName"]];
            }
        }
        callBack(self.orderStatusList,error);
    }];
}

//订单类型列表
-(void)findOrderTypeListWithCallBack:(findBlock)callBack{
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"Dictionary"];
    bquery.cachePolicy = kBmobCachePolicyNetworkElseCache;
    @weakify(self)
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        @strongify(self)
        for (BmobObject *obj in array) {
            if ([[obj objectForKey:@"dicType"] intValue] == 3) {
                [self.orderTypeList addObject:[obj objectForKey:@"dataName"]];
            }
        }
        callBack(self.orderTypeList,error);
    }];
}

//包裹大小列表
-(void)findBagTypeListWithCallBack:(findBlock)callBack{
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"Dictionary"];
    bquery.cachePolicy = kBmobCachePolicyNetworkElseCache;
    @weakify(self)
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        @strongify(self)
        for (BmobObject *obj in array) {
            if ([[obj objectForKey:@"dicType"] intValue] == 5) {
                [self.bagTypeList addObject:[obj objectForKey:@"dataName"]];
            }
        }
        callBack(self.bagTypeList,error);
    }];
}

@end
