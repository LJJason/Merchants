//
//  TRAuthorizationView.h
//  TRMerchants
//
//  Created by wgf on 16/10/8.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRAuthorizationView : UIView

/**
 *  审核完成需要传入
 */
@property (weak, nonatomic) IBOutlet UILabel *label;

+ (instancetype)authorizationView;

/**
 *  认证失败的界面
 */
@property (weak, nonatomic) IBOutlet UIView *errorView;

/** 重新提交按钮点击时回调 */
@property (nonatomic, copy) void (^reloadBlock)();

@end
