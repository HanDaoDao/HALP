//
//  HPOrder.h
//  HALP
//
//  Created by 韩钊 on 2018/4/17.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HPDictionary.h"
#import "HPCanteenContent.h"
#import "HPUser.h"

@interface HPOrder : NSObject

@property(nonatomic,copy) NSString *objectID;
@property(nonatomic,assign) NSNumber *validTime;
@property(nonatomic,strong) HPUser *creator;
@property(nonatomic,strong) HPUser *helper;
@property(nonatomic,assign) NSNumber *orderHonor;
@property(nonatomic,strong) NSString *orderSchool;
@property(nonatomic,strong) NSNumber *orderStatus;
@property(nonatomic,strong) NSNumber *orderType;
@property(nonatomic,strong) NSDate *startAt;
@property(nonatomic,strong) NSDate *endAt;
@property(nonatomic,strong) NSDate *createdAt;
@property(nonatomic,strong) NSDate *updatedAt;
@property(nonatomic,strong) HPCanteenContent *content;
@property(nonatomic,copy) NSString *cancelReason;

@end
