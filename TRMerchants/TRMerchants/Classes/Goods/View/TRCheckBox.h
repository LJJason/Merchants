//
//  TRCheckBox.h
//  TRMerchants
//
//  Created by wgf on 16/10/9.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TRCheckBoxDelegate <NSObject>

-(void)handleAccordingIndex:(NSInteger)index selected:(BOOL)select;

@end

@interface TRCheckBox : UIButton

@property (nonatomic,assign) BOOL defaultStatu; //默认选中状态
@property (nonatomic,assign) id<TRCheckBoxDelegate>delegate;

@end
