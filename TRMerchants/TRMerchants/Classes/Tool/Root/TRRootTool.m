//
//  TRRootTool.m
//  TRMerchants
//
//  Created by wgf on 16/9/28.
//  Copyright © 2016年 wgf. All rights reserved.
// 选择根控制器

#import "TRRootTool.h"
#import "TRGuideViewController.h"
#import "TRAccountTool.h"
#import "TRMainViewController.h"

@implementation TRRootTool

// 选择根控制器
+ (void)chooseRootViewController:(UIWindow *)window
{
    if ([TRAccountTool account]) {//已经登录过
        
        TRMainViewController *main = [TRMainViewController viewControllerWtithMainStoryboardIdentifier:@"TRMainViewController"];
        
        window.rootViewController = main;
    }else {   // 没有登录
        //显示导航界面
        TRGuideViewController *trgVc = [TRGuideViewController instantiateInitialViewControllerWithStoryboardName:@"LoginAndRegist"];
        // 设置窗口的根控制器
        window.rootViewController = trgVc;
    }
}

@end
