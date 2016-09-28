//
//  TRAccountTool.m
//  TRMerchants
//
//  Created by wgf on 16/9/28.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRAccountTool.h"
#import "TRAccountParam.h"

#define LoginUrl @"http://yearwood.top/TRMerchants/login"

@implementation TRAccountTool

+ (void)accountWithPhoneNum:(NSString *)phoneNum pwd:(NSString *)pwd success:(void (^)())success failure:(void (^)(NSError *))failure {
    TRAccountParam *param = [[TRAccountParam alloc] init];
    param.phoneNum = phoneNum;
    param.pwd = pwd;
    
    [TRHttpTool POST:LoginUrl parameters:param.mj_keyValues success:^(id responseObject) {
        
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
    
}

@end
