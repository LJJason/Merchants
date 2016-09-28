//
//  TRAccountTool.h
//  TRMerchants
//
//  Created by wgf on 16/9/28.
//  Copyright © 2016年 wgf. All rights reserved.
//  专门处理账号业务

#import <Foundation/Foundation.h>
@class TRAccount;


@interface TRAccountTool : NSObject

/**
 *  归档用户账号
 *
 *  @param account 用户模型
 */
+ (void)saveAccount:(TRAccount *)account;

/**
 *  读取用户
 *
 *  @return 用户模型
 */
+ (TRAccount *)account;

//用户登录
+ (void)accountWithPhoneNum:(NSString *)phoneNum pwd:(NSString *)pwd success:(void(^)())success failure:(void(^)(NSError *error))failure;

@end
