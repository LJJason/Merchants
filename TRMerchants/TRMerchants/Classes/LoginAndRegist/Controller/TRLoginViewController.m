//
//  TRLoginViewController.m
//  TRMerchants
//
//  Created by wgf on 16/9/27.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRLoginViewController.h"
#import "TRAccountTool.h"
#import <SVProgressHUD.h>
#import "TRAccount.h"

@interface TRLoginViewController ()

//用户名文本框
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
//密码文本框
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;


@end

@implementation TRLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    TRAccount *account = [TRAccountTool account];
    NSLog(@"%@", account.uid);
}

//登录
- (void)login
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    [self.view endEditing:YES];
    
    NSString *userName = self.userNameTextField.text;
    NSString *pwd = self.pwdTextField.text;
    
    if (userName.length > 0 && pwd.length > 0) {
        [SVProgressHUD showWithStatus:@"登录中..."];
        
        
        
        [TRAccountTool loginWithPhoneNum:userName pwd:pwd success:^(TRLoginState state) {
            NSLog(@"%zd", state);
            
            
            
            [SVProgressHUD dismiss];
        } failure:^(NSError *error) {
            NSLog(@"%@", error);
            
            [SVProgressHUD showErrorWithStatus:@"登录失败!请检查网络连接!"];
            
            
        }];
    }else {
        [SVProgressHUD showErrorWithStatus:@"请输入账号或密码!"];
        [self dimiss];
    }
    
    
}




//- (void)dealloc {
//    TRLog(@"滚蛋");
//}
//延迟隐藏SVProgressHUD
- (void)dimiss{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}


@end
