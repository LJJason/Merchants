//
//  TRAuthorizationStateTool.h
//  TRMerchants
//
//  Created by wgf on 16/10/9.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    TRAuthorizationStateNotAudit                = 10000,//未审核
    TRAuthorizationStateToAudit                 = 10001,//待审核
    TRAuthorizationStateOK                      = 10002, //已认证
    TRAuthorizationStateFailed                  = 10004  //认证失败
}TRAuthorizationState;


@interface TRAuthorizationStateTool : NSObject

/**
 *  获取认证状态
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)authorizationStateWithSuccess:(void (^)(TRAuthorizationState state))success failure:(void (^)())failure;

@end
