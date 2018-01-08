//
//  ViewController.m
//  HALP
//
//  Created by 韩钊 on 2018/1/4.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    BmobObject *studentSorce = [BmobObject objectWithClassName:@"StudentSorce"];
    [studentSorce setObject:@"小明" forKey:@"name"];
    [studentSorce setObject:@20 forKey:@"age"];
    [studentSorce setObject:[NSNumber numberWithBool:YES] forKey:@"cheatMode"];
    [studentSorce saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        NSLog(@"====%d",isSuccessful);
    }];
    
    BmobQuery *queryStudentSorce = [BmobQuery queryWithClassName:@"StudentSorce"];
    [queryStudentSorce getObjectInBackgroundWithId:@"0b0a64fae2" block:^(BmobObject *object, NSError *error) {
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
