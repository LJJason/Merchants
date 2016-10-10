//
//  TRAddRoomParam.h
//  TRMerchants
//
//  Created by wgf on 16/10/10.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRAddRoomParam : NSObject

/** 图片路径 */
@property (nonatomic, copy) NSString *photosUrl;

/** 地址 */
@property (nonatomic, copy) NSString *address;

/** 房间配置 */
@property (nonatomic, copy) NSString *configuration;

/** 商家提供的联系方式 */
@property (nonatomic, copy) NSString *phoneNum;

/** 房间描述 */
@property (nonatomic, copy) NSString *describe;

/** 价格 */
@property (nonatomic, assign) NSInteger price;

/** uid */
@property (nonatomic, copy) NSString *uid;

@end
