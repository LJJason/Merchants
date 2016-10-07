//
//  TRRegistViewController.m
//  TRMerchants
//
//  Created by wgf on 16/9/27.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRRegistViewController.h"
#import "TRRegistTool.h"
#import "TRGetVcCodeParam.h"
#import "TRRegistParam.h"
#import "TRGuideViewController.h"


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




/** 定时器 */
@property (nonatomic, strong) NSTimer *timer;

/** 倒计时索引 */
@property (nonatomic, assign) NSInteger index;

@end

@implementation TRRegistViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.index = 60;
}
/**
 *  获取验证码
 */
- (IBAction)getVerificationCode {
    
    
    TRGetVcCodeParam *param = [[TRGetVcCodeParam alloc] init];
    if (self.userNameTextField.text.length <= 0) {
        [Utilities popUpAlertViewWithMsg:@"请输入手机号" andTitle:nil];
        return;
    }
    
    
    param.phoneNum = self.userNameTextField.text;
    
    [TRRegistTool getVcCodeWithParam:param success:^(TRGetVcCodeState state) {
        
        switch (state) {
            case TRGetVcCodeStateOK:
                [Toast makeText:@"发送成功!"];
                [self showCountDown];
                break;
            case TRGetVcCodeStateInvalidFormat:
                [Toast makeText:@"手机号格式错误!"];
                break;
                
            case TRGetVcCodeStateTooOften:
                [Toast makeText:@"手机号使用太频繁!"];
                break;
            case TRGetVcCodeStateShielding:
                [Toast makeText:@"手机号使用太频繁,被屏蔽数日!"];
                break;
            
            default:
                [Toast makeText:@"未知错误!!"];
            break;
        }
        
        
    } failure:^(NSError *error) {
        [Toast makeText:@"请检查网络连接!"];
    }];
    
    
}

- (void)showCountDown{
    self.index = 60;
    [self.vcCodeButton setTitle:@"60秒后重新获取" forState:UIControlStateDisabled];
    self.vcCodeButton.enabled = NO;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countdown) userInfo:nil repeats:YES];
    self.timer = timer;
    
    [self.vcCodeButton setBackgroundColor:[UIColor lightGrayColor]];
}


/**
 *  完成注册
 */
- (void)login {
    [super login];
    
    if (!(self.userNameTextField.text.length > 0 &&
        self.pwdTextFiled.text.length > 0 &&
        self.againPwdTextFiled.text.length > 0 &&
        self.vcCodeTextField.text.length > 0)) {
        [Utilities popUpAlertViewWithMsg:@"请将信息填写完整!" andTitle:nil];
        return;
    }
    
    if (![self.pwdTextFiled.text isEqualToString:self.againPwdTextFiled.text]) {
        [Utilities popUpAlertViewWithMsg:@"两次输入的密码不一致!" andTitle:nil];
        return;
    }
    
    TRRegistParam *param = [[TRRegistParam alloc] init];
    param.phoneNum = self.userNameTextField.text;
    param.pwd = self.pwdTextFiled.text;
    param.verificationCode = self.vcCodeTextField.text;
    [TRProgressTool showWithMessage:@"注册中..."];
    [TRRegistTool registWithParam:param success:^(TRRegistState state) {
        
        switch (state) {
            case TRRegistStateOK:
                [TRProgressTool dismiss];
                [Toast makeText:@"注册成功, 请登录!!"];
                
                break;
            case TRRegistStateUserExist:
                [Toast makeText:@"用户已存在!!"];
               
                
                break;
                
            default:
                
                [Toast makeText:@"验证码错误!!"];
                break;
        }
        
    } failure:^(NSError *error) {
        [Toast makeText:@"请检查网络连接!!"];
    }];
    
}


/**
 *  倒计时
 */
- (void)countdown {
    self.index--;
    if (self.index >= 0) {
        NSString *title = [NSString stringWithFormat:@"%zd秒后重新获取", self.index];
        [self.vcCodeButton setTitle:title forState:UIControlStateDisabled];
//        [self.vcCodeButton setBackgroundColor:[UIColor lightGrayColor]];
    }else {
        //停止定时器
        [self.timer invalidate];
        self.timer = nil;
        self.vcCodeButton.enabled = YES;
        [self.vcCodeButton setBackgroundColor:TRColor(0, 191, 248, 1.0)];
    }
    
    
}

@end
