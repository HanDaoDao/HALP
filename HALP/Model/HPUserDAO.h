//
//  HPUserDAO.h
//  HALP
//
//  Created by 韩钊 on 2018/4/17.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HPDictionary.h"

@interface HPUserDAO : NSObject

@property(nonatomic,copy) NSString *objectID;
@property(nonatomic,copy) NSString *userName;         //用户名
@property(nonatomic,copy) NSString *password;       //登录密码
@property(nonatomic,copy) NSString *phone;          //电话
@property(nonatomic,strong) HPDictionary *stuSchool;     //学号
@property(nonatomic,copy) NSString *stuName;        //姓名
@property(nonatomic,copy) NSString *stuID;             //学号
@property(nonatomic,copy) NSString *stuHonor;       //荣誉值
@property(nonatomic,strong) HPDictionary *sex;        //性别
@property(nonatomic,copy) NSString *nickName;       //昵称
@property(nonatomic,copy) NSString *icon;           //头像
@property(nonatomic,assign) Boolean emailVerified;
@property(nonatomic,copy) NSString *email;
@property(nonatomic,strong) NSDate *createdAt;
@property(nonatomic,strong) NSDate *updatedAt;



@end
