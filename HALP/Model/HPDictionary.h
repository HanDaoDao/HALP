//
//  HPDictionary.h
//  HALP
//
//  Created by 韩钊 on 2018/4/17.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HPDictionary : NSObject

@property(nonatomic,copy) NSString *objectID;
@property(nonatomic,assign) NSNumber *dicType;
@property(nonatomic,assign) NSNumber *dataType;
@property(nonatomic,copy) NSString *dataName;
@property(nonatomic,copy) NSDate *createAt;
@property(nonatomic,copy) NSDate *updateAt;

+(void)findAllDictionary;

@end
