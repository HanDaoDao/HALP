//
//  HPOperationBomb.m
//  HALP
//
//  Created by HanZhao on 2018/1/11.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPOperationBomb.h"
#import "BmobSDK.framework/Headers/Bmob.h"

@implementation HPOperationBomb

//增加数据
-(void)addObjectToBmob{
    BmobObject *studentSorce = [BmobObject objectWithClassName:@"StudentSorce"];
    [studentSorce setObject:@"小明" forKey:@"name"];
    [studentSorce setObject:@20 forKey:@"age"];
    [studentSorce setObject:[NSNumber numberWithBool:YES] forKey:@"cheatMode"];
    [studentSorce saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        NSLog(@"====%d",isSuccessful);
    }];
}

//查找数据
-(void)queryObjectToBmob{
    BmobQuery *queryStudentSorce = [BmobQuery queryWithClassName:@"StudentSorce"];
    [queryStudentSorce getObjectInBackgroundWithId:@"3eadd18221" block:^(BmobObject *object, NSError *error) {
        if (error) {
            NSLog(@"哎呀，出错了，原因是%@",error);
        } else {
            if (object) {
                NSString *nameString = [object objectForKey:@"name"];
                BOOL cheat = [[object objectForKey:@"cheatMode"] boolValue];
                NSLog(@"%@-----%i",nameString,cheat);
            }
        }
    }];
}

//修改数据
-(void)updateObjectToBmob{
    BmobQuery *chageQuery  = [BmobQuery queryWithClassName:@"StudentSorce"];
    [chageQuery getObjectInBackgroundWithId:@"9dc93203e6" block:^(BmobObject *object, NSError *error) {
        if (error) {
            NSLog(@"出错不能修改\n");
        }
        else{
            if (object) {
                BmobObject *bObject = [BmobObject objectWithoutDataWithClassName:object.className objectId:object.objectId];
                [bObject setObject:@"小红" forKey:@"name"];
                [bObject updateInBackground];
                NSLog(@"修改成功\n");
            }
            else{
                NSLog(@"对象不存在\n");
            }
        }
    }];
}

//删除数据
-(void)deleteObjectToBmob{
    BmobQuery *bQuery  = [BmobQuery queryWithClassName:@"StudentSorce"];
    [bQuery getObjectInBackgroundWithId:@"26c6eb9634" block:^(BmobObject *object, NSError *error) {
        if (error) {
            NSLog(@"没有找到删除的数据\n");
        }else {
            if (object) {
                [object deleteInBackground];
                NSLog(@"删除成功！\n");
            }
            else{
                NSLog(@"对象不存在\n");
            }
        }
    }];
}

@end
