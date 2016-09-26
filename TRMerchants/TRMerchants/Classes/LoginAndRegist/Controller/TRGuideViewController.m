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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
