//
//  TRBackButton.m
//  TRMerchants
//
//  Created by wgf on 16/10/7.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRBackButton.h"

@implementation TRBackButton

+ (instancetype)backButtonWithTarget:(id)target action:(SEL)action{
    //创建导航条左边返回的按钮
    TRBackButton *button = [[self alloc] init];
    [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.bounds = CGRectMake(0, 0, 70, 30);
    button.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    
    return button;
}

@end
