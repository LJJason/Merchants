//
//  TRLoginAndRegistViewController.m
//  TRMerchants
//
//  Created by wgf on 16/9/27.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRLoginAndRegistViewController.h"

@interface TRLoginAndRegistViewController ()

@end

@implementation TRLoginAndRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置导航条的一些相关属性
    [self setupNav];
    
}

#pragma mark <导航条的设置>
- (void)setupNav{
    //创建导航条右边的按钮
    
    UIButton *rightBtn = [[UIButton alloc] init];
    [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    rightBtn.bounds = CGRectMake(0, 0, 70, 30);
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    //创建导航条左边返回的按钮
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    button.bounds = CGRectMake(0, 0, 70, 30);
    button.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

#pragma mark <返回>
- (void)cancel {
    
    [UIView animateWithDuration:0.5 animations:^{
        self.navigationController.view.frame = CGRectMake(TRScreenW, 0, TRScreenW, TRScreenH);
        self.annimation();
    } completion:^(BOOL finished) {
        if (self.back) {
            self.back();
        }
    }];
    
    
}

#pragma mark <登录/注册>
- (void)login{
    [self.view endEditing:YES];
}


//- (void)dealloc {
//    TRLog(@"滚蛋");
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}



@end
