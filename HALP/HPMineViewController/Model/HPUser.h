//
//  HPUser.h
//  HALP
//
//  Created by HanZhao on 2018/4/8.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HPDictionary.h"
#import "BmobSDK.framework/Headers/Bmob.h"

@interface HPUser : BmobUser

typedef NS_ENUM(NSInteger,Sex)
{
    gilr = 0,
    boy
};

typedef void(^findUserBlock)(HPUser *user, NSError *error);

@property(nonatomic,copy) NSString *objectID;
@property(nonatomic,copy) NSString *stuName;        //姓名
@property(nonatomic,strong) NSString *nickName;       //昵称
@property(nonatomic,assign) Sex sex;                //性别
@property(nonatomic,copy) NSString *stuID;          //学号
@property(nonatomic,copy) NSString *stuHonor;       //荣誉值
@property(nonatomic,copy) NSString *icon;           //头像
@property(nonatomic,strong) NSMutableArray *addressList;      //我的地址

+(HPUser *)sharedHPUser;
-(void)initUser;

@end
