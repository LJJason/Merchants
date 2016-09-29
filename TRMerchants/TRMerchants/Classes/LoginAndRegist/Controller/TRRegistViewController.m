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

/** 按钮状态标记 */
@property (nonatomic, assign) BOOL flag;


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
    if (!self.flag) {
        self.index = 60;
        [self.vcCodeButton setTitle:@"60秒后重新获取" forState:UIControlStateDisabled];
        self.vcCodeButton.enabled = NO;
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countdown) userInfo:nil repeats:YES];
        self.timer = timer;
        
        [self.vcCodeButton setBackgroundColor:[UIColor lightGrayColor]];

    }
    
}

/**
 *  完成注册
 */
- (void)login {
    [super login];
    
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
