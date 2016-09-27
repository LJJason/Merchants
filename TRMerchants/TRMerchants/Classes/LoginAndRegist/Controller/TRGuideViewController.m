//
//  TRGuideViewController.m
//  TRMerchants
//
//  Created by wgf on 16/9/21.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRGuideViewController.h"
#import "TRLoginViewController.h"

@interface TRGuideViewController ()

/** 登录按钮 */
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UIButton *registBtn;

@end

@implementation TRGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //设置登录和注册按钮的一些属性
    [self setupLoginAndRegistBtn];
}

/** 设置登录和注册按钮的一些属性 */
- (void)setupLoginAndRegistBtn{
    
    self.loginBtn.layer.borderWidth = 3;
    self.loginBtn.layer.borderColor = [[UIColor redColor] CGColor];
    self.loginBtn.layer.cornerRadius = 7;
    
    self.registBtn.layer.cornerRadius = 7;
}

//点击登录按钮
- (IBAction)login {
    
    [self pushToNextViewController:[TRNavigationController viewControllerWtithStoryboardName:@"LoginAndRegist" identifier:@"login"]];
    
}

- (IBAction)regist {
    
    [self pushToNextViewController:[TRNavigationController viewControllerWtithStoryboardName:@"LoginAndRegist" identifier:@"regist"]];
}

- (void)pushToNextViewController:(UIViewController *)nav {
    
    TRLoginAndRegistViewController *vc = nav.childViewControllers[0];
    vc.back = ^ {
        
        if (self.childViewControllers.count > 0) {
            [self setValue:nil forKey:@"childViewControllers"];
        }
    };
    vc.annimation = ^ {
        self.view.x = 0;
    };
    
    [[UIApplication sharedApplication].keyWindow addSubview:nav.view];
    [self addChildViewController:nav];
    nav.view.frame = CGRectMake(TRScreenW, 0, TRScreenW, TRScreenH);
    
    [UIView animateWithDuration:0.5 animations:^{
        self.view.x = -TRScreenW;
        nav.view.x = 0;
    }];
}

@end
