//
//  HPExpOrder.m
//  HALP
//
//  Created by HanZhao on 2018/3/22.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "HPExpOrder.h"

@implementation HPExpOrder

-(BOOL)saveOneOrder:(HPExpOrder *)oneOrder fromTableView:(UITableView *)tableView andCellText:(HPWriteOrderTableViewCell *)orderCell{
    if (!oneOrder) {
        NSArray *array = [tableView indexPathsForVisibleRows];
        NSMutableArray *arrayText = [[NSMutableArray alloc]init];
        int i = 0;
        
        for (NSIndexPath *indexPath in array) {
            orderCell = [tableView cellForRowAtIndexPath:indexPath];
            if (orderCell.numberTextField.text.length == 0) {
                return NO;
            }
            arrayText[i] = orderCell.numberTextField.text;
            i++;
            NSLog(@"%@",orderCell.numberTextField.text);
        }
        oneOrder = [[HPExpOrder alloc] init];
        oneOrder.name = arrayText[0];
        oneOrder.tel = arrayText[1];
        oneOrder.expNumber = arrayText[2];
        oneOrder.expArea = arrayText[3];
    }
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:oneOrder,@"appendOneOrder", nil];
    NSNotification *notification = [NSNotification notificationWithName:@"appendOneOrderTongzhi" object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    return YES;
}


@end
