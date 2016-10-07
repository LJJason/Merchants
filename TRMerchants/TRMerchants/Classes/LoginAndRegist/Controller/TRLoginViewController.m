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
#import "TRMainViewController.h"

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
}

//登录
- (void)login
{
    [super login];
    
    NSString *userName = self.userNameTextField.text;
    NSString *pwd = self.pwdTextField.text;
    
    if (userName.length > 0 && pwd.length > 0) {
        [TRProgressTool showWithMessage:@"登录中..."];
        [TRAccountTool loginWithPhoneNum:userName pwd:pwd success:^(TRLoginState state) {

            
            switch (state) {
                case TRLoginStateOK:
                    
                    [self showMainVc];
                    
                    break;
                case TRLoginStateAccountNotExist:
                    
                    [Toast makeText:@"用户不存在!!"];
                    
                    break;
                    
                default:
                    [Toast makeText:@"用户名或密码输入错误!!"];
                    
                    break;
            }
            
            
            [TRProgressTool dismiss];
        } failure:^(NSError *error) {
            TRLog(@"%@", error);
            [Toast makeText:@"登录失败, 请检查网络连接!!"];
        }];
    }else {
        [Utilities popUpAlertViewWithMsg:@"请输入账号或密码" andTitle:nil];
    }
    
    
}

- (void)showMainVc{
    TRMainViewController *main = [TRMainViewController viewControllerWtithMainStoryboardIdentifier:@"TRMainViewController"];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = main;
}



//- (void)dealloc {
//    TRLog(@"滚蛋");
//}
////延迟1.0秒隐藏SVProgressHUD
//- (void)dimiss{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [SVProgressHUD dismiss];
//    });
//}


@end
