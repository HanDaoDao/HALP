//
//  HPExpOrder.h
//  HALP
//
//  Created by HanZhao on 2018/3/22.
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
