//
//  TRLoginAndRegistViewController.h
//  TRMerchants
//
//  Created by wgf on 16/9/27.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRLoginAndRegistViewController : UIViewController

/** 点击返回按钮 */
@property (nonatomic, copy) void (^back)();

/** 点击返回按钮执行动画前回调 */
@property (nonatomic, copy) void (^annimation)();

/**
 *  预留方法 点击右上角的完成按钮
 *  子类自行实现
 */
- (void)login;

@end
