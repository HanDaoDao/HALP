//
//  HPDictionary.h
//  HALP
//
//  Created by 韩钊 on 2018/4/17.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HPDictionary : NSObject

typedef void(^findBlock)(NSArray *array, NSError *error);

@property(nonatomic,copy) NSString *objectID;
@property(nonatomic,assign) NSNumber *dicType;
@property(nonatomic,assign) NSNumber *dataType;
@property(nonatomic,copy) NSString *dataName;
@property(nonatomic,copy) NSDate *createAt;
@property(nonatomic,copy) NSDate *updateAt;
@property(nonatomic,copy) NSArray *allDictionaryList;
@property(nonatomic,strong) NSMutableArray *sexList;
@property(nonatomic,copy) NSMutableArray *orderTypeList;
@property(nonatomic,copy) NSMutableArray *orderStatusList;
@property(nonatomic,copy) NSMutableArray *bagTypeList;
@property(nonatomic,copy) NSDictionary *schollList;

+(void)findAllDictionary;
-(void)findSexListWithCallBack:(findBlock)callBack;
-(void)findOrderTypeListWithCallBack:(findBlock)callBack;
-(void)findOrderTypeListWithCallBack:(findBlock)callBack;

@end
