//
//  TRLoginViewController.m
//  TRMerchants
//
//  Created by wgf on 16/9/27.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRLoginViewController.h"
#import "TRAccountTool.h"

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
    [TRAccountTool loginWithPhoneNum:self.userNameTextField.text pwd:self.pwdTextField.text success:^(TRLoginState state) {
        NSLog(@"%zd", state);
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}




//- (void)dealloc {
//    TRLog(@"滚蛋");
//}



@end
