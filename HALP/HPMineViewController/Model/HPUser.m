//
//  HPUser.m
//  HALP
//
//  Created by HanZhao on 2018/4/8.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPUser.h"

@implementation HPUser

//单例
static HPUser* _instance;
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
        }
    });
    return _instance;
}

+(HPUser *)sharedHPUser{
    return [[self alloc]init];
}

// 为了严谨，也要重写copyWithZone 和 mutableCopyWithZone
-(id)copyWithZone:(NSZone *)zone
{
    return _instance;
}
-(id)mutableCopyWithZone:(NSZone *)zone
{
    return _instance;
}

-(void)initUser{
    BmobUser *bUser = [BmobUser currentUser];
    
    self.objectID = bUser.objectId;
    
    self.nickName = [bUser objectForKey:@"nickName"];
    
    BmobUser *sex = [bUser objectForKey:@"sex"];
    if ([sex.objectId isEqualToString:@"qx2fEEEM"]) {
        self.sex = 0;
    }
    else
        self.sex = 1;
    
    BmobFile *iconFile = (BmobFile *)[bUser objectForKey:@"userIcon"];
    self.icon = iconFile.url;
    
    if ([bUser objectForKey:@"stuHonor"] == NULL) {
        self.stuHonor = 0;
    }else{
        self.stuHonor =  [bUser objectForKey:@"stuHonor"];
    }
    self.stuID = [bUser objectForKey:@"stuId"];
    self.mobilePhoneNumber = [bUser objectForKey:@"mobilePhoneNumber"];
    
    self.addressList = [[bUser objectForKey:@"addr"] mutableCopy];
}

@end
