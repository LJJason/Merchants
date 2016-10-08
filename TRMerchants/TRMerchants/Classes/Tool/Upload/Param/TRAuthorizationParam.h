//
//  TRAuthorizationParam.h
//  TRMerchants
//
//  Created by wgf on 16/10/8.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRAuthorizationParam : NSObject

/** uid */
@property (nonatomic, copy) NSString *uid;

/** 实名认证人的姓名 */
@property (nonatomic, copy) NSString *name;

/** 身份证号 */
@property (nonatomic, copy) NSString *idCard;

/** 身份证图片路径 */
@property (nonatomic, copy) NSString *photos;

@end
