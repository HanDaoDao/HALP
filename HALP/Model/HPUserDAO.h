//
//  HPUserDAO.h
//  HALP
//
//  Created by 韩钊 on 2018/4/17.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HPDictionary.h"
#import "BmobSDK.framework/Headers/Bmob.h"

@interface HPUserDAO : BmobUser

@property(nonatomic,copy) NSString *objectID;
@property(nonatomic,copy) NSString *stuName;        //姓名
@property(nonatomic,copy) NSString *stuID;             //学号
@property(nonatomic,copy) NSString *stuHonor;       //荣誉值
@property(nonatomic,strong) HPDictionary *sex;        //性别
@property(nonatomic,copy) NSString *nickName;       //昵称
@property(nonatomic,copy) NSString *icon;           //头像



@end
