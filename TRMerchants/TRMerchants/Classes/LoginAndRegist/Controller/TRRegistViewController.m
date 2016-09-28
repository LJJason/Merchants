//
//  TRRegistViewController.m
//  TRMerchants
//
//  Created by wgf on 16/9/27.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRRegistViewController.h"

@interface TRRegistViewController ()

/**
 *  用户名
 */
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
/**
 *  密码
 */
@property (weak, nonatomic) IBOutlet UITextField *pwdTextFiled;
/**
 *  再次密码
 */
@property (weak, nonatomic) IBOutlet UITextField *againPwdTextFiled;
/**
 *  验证码
 */
@property (weak, nonatomic) IBOutlet UITextField *vcCodeTextField;

/**
 *  获取验证码按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *vcCodeButton;

@end

@implementation TRRegistViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
/**
 *  获取验证码
 */
- (IBAction)getVerificationCode {
    
    
    
}

/**
 *  完成注册
 */
- (void)login {
    [super login];
    
}

@end
