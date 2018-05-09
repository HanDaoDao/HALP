//
//  UIImageView+HPHelper.m
//  HALP
//
//  Created by 韩钊 on 2018/5/8.
//  Copyright © 2018年 HanZhao. All rights reserved.
//

#import "UIImageView+HPHelper.h"
#define LFLANIMATEDURATION 0.3

static CGRect originFrame;

@implementation UIImageView (HPHelper)

- (void)HPHeadimageBrowser{
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHeadimageHandle)]];
}

- (void)tapHeadimageHandle{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    originFrame = [self convertRect:self.bounds toView:window];
    NSLog(@"oldframe%@",NSStringFromCGRect(originFrame));
    backgroundView.backgroundColor =[UIColor blackColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:originFrame];
    imageView.tag = 1111;
    [imageView setImage:self.image];
  
    [backgroundView addSubview:imageView];
    [window addSubview:backgroundView];
    [backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissAction:)]];
    //  view big  eadimageBrowser
    [UIView animateWithDuration:LFLANIMATEDURATION animations:^{
        CGFloat y,width,height;
        y = ([UIScreen mainScreen].bounds.size.height - self.image.size.height * [UIScreen mainScreen].bounds.size.width / self.image.size.width) * 0.5;
        width = [UIScreen mainScreen].bounds.size.width;
        height = self.image.size.height * [UIScreen mainScreen].bounds.size.width / self.image.size.width;
        [imageView setFrame:CGRectMake(0, y, width, height)];
    } completion:nil];
}

- (void)dismissAction:(UITapGestureRecognizer *)tapRecognizer{
    UIView *backgroundView= tapRecognizer.view;
    [UIView animateWithDuration:LFLANIMATEDURATION animations:^{
        [[backgroundView viewWithTag:1111] setFrame:originFrame];
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}

@end
