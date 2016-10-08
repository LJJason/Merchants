
//
//  TRAuthorizationStateTool.m
//  TRMerchants
//
//  Created by wgf on 16/10/9.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRAuthorizationStateTool.h"
#import "TRAccount.h"
#import "TRAccountTool.h"

@implementation TRAuthorizationStateTool

+ (void)authorizationStateWithSuccess:(void (^)(TRAuthorizationState))success failure:(void (^)())failure {
    TRAccount *account = [TRAccountTool account];
    
    NSDictionary *param = @{@"uid" : account.uid};
    
    [TRHttpTool GET:TRGetAuthenticationStateUrl parameters:param success:^(id responseObject) {
        //        TRLog(@"%@", responseObject);
        
        if (success) {
            NSInteger state = [responseObject[@"state"] integerValue];
            
            if (state == 10001) {//待审核
                success(TRAuthorizationStateToAudit);
            }else if (state == 10002) {//已审核
                success(TRLoginStateAccountOK);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure();
        }
    }];
}


@end
