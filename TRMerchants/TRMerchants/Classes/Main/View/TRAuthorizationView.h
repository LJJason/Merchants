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

@end
