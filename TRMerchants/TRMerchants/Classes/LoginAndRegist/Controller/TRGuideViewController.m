//
//  TRGuideViewController.m
//  TRMerchants
//
//  Created by wgf on 16/9/21.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRGuideViewController.h"

@interface TRGuideViewController ()

/** 登录按钮 */
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UIButton *registBtn;

@end

@implementation TRGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.loginBtn.layer.borderWidth = 3;
    self.loginBtn.layer.borderColor = [[UIColor redColor] CGColor];
    self.loginBtn.layer.cornerRadius = 7;
    
    self.registBtn.layer.cornerRadius = 7;
    
}

- (IBAction)login {
}

- (IBAction)regist {
}


@end
