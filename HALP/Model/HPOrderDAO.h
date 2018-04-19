//
//  HPOrderDAO.h
//  HALP
//
//  Created by 韩钊 on 2018/4/17.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HPDictionary.h"

@interface HPOrderDAO : NSObject

@property(nonatomic,copy) NSString *objectID;
@property(nonatomic,assign) NSNumber *validTime;
@property(nonatomic,strong) HPDictionary *creator;
@property(nonatomic,strong) HPDictionary *helper;
@property(nonatomic,assign) NSNumber *orderHonor;
@property(nonatomic,strong) HPDictionary *orderSchool;
@property(nonatomic,strong) HPDictionary *orderStatus;
@property(nonatomic,strong) HPDictionary *orderType;
@property(nonatomic,strong) NSDate *startAt;
@property(nonatomic,strong) NSDate *endAt;
@property(nonatomic,strong) NSDate *createdAt;
@property(nonatomic,strong) NSDate *updatedAt;
@property(nonatomic,copy) NSString *content;



@end
