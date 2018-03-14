//
//  HPUser.h
//  HALP
//
//  Created by HanZhao on 2018/3/8.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HPUser : NSObject

typedef NS_ENUM(NSInteger,Sex)
{
    gilr = 0,
    boy
};

@property(nonatomic,copy) NSString *name;           //姓名
@property(nonatomic,assign) Sex sex;                 //性别
@property(nonatomic,copy) NSString *ID;             //学号
@property(nonatomic,copy) NSString *password;       //登录密码
@property(nonatomic,copy) NSString *phone;          //电话
@property(nonatomic,copy) NSString *professional;   //专业班级
@property(nonatomic,assign) NSInteger money;        //拥有的名誉值（钱）
@property(nonatomic,copy) NSString *imagePath;          //头像

+(HPUser *)sharedHPUser;

@end
