//
//  TRRoom.h
//  TRMerchants
//
//  Created by wgf on 16/10/11.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRRoom : NSObject


/** 图片 */
@property (nonatomic, strong) NSArray *photos;

/** 描述 */
@property (nonatomic, copy) NSString *describes;

/** 销量 */
@property (nonatomic, assign) NSInteger sales;

/** 价格 */
@property (nonatomic, assign) NSInteger price;

/** 收藏的用户账号 */
@property (nonatomic, strong) NSArray *collections;

@end
