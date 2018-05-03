//
//  HPExpOrder.h
//  HALP
//
//  Created by 韩钊 on 2018/5/3.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HPWriteOrderTableViewCell.h"

@interface HPExpOrder : NSObject

@property(nonatomic,copy) NSString* name;
@property(nonatomic,copy) NSString* tel;
@property(nonatomic,copy) NSString* expNumber;
@property(nonatomic,copy) NSString* expArea;
@property(nonatomic,copy) NSString* expMark;

-(BOOL)saveOneOrder:(HPExpOrder *)oneOrder fromTableView:(UITableView *)tableView andCellText:(HPWriteOrderTableViewCell *)orderCell;


@end
