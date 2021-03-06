//
//  TRAccountTool.m
//  TRMerchants
//
//  Created by wgf on 16/9/28.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRAccountTool.h"
#import "TRAccountParam.h"
#import "TRAccount.h"


#define TRAccountFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]
#define TRUserFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"user.data"]

@implementation TRAccountTool

+ (void)loginWithPhoneNum:(NSString *)phoneNum pwd:(NSString *)pwd success:(void (^)(TRLoginState))success failure:(void (^)(NSError *))failure {
    TRAccountParam *param = [[TRAccountParam alloc] init];
    param.phoneNum = phoneNum;
    param.pwd = pwd;
    
    [TRHttpTool POST:TRLoginUrl parameters:param.mj_keyValues success:^(id responseObject) {
        
        NSString *uid = responseObject[@"uid"];
        if ([uid isEqualToString:phoneNum]) {
            [TRAccountTool saveAccount:[TRAccount accountWithDict:responseObject]];
            
            if (success) {
                success(TRLoginStateOK);
            }
            
        }else if ([uid isEqualToString:@"0"]) {
            
            if (success) {
                success(TRLoginStatePwdMistake);
            }
            
        }else {
            if (success) {
                success(TRLoginStateAccountNotExist);
            }
            
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
        
    }];
    
}

+ (void)saveAccount:(TRAccount *)account {
    [NSKeyedArchiver archiveRootObject:account toFile:TRAccountFileName];
}

//在类方法无法使用成员变量, 使用静态变量代替
static TRAccount *_account;

+ (TRAccount *)account {
    if (_account == nil) {
        
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:TRAccountFileName];
    }
    
    
    return _account;
}

+ (void)saveUser:(TRUser *)user {
    [NSKeyedArchiver archiveRootObject:user toFile:TRUserFileName];
}

static TRUser *_user;

+ (TRUser *)user {
    if (_user == nil) {
        _user = [NSKeyedUnarchiver unarchiveObjectWithFile:TRUserFileName];
    }
    return _user;
}

@end
