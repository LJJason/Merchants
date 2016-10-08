//
//  TRAuthorizationView.m
//  TRMerchants
//
//  Created by wgf on 16/10/8.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRAuthorizationView.h"

@implementation TRAuthorizationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)authorizationView{
    return [[[NSBundle mainBundle] loadNibNamed:@"TRAuthorizationView" owner:nil options:nil] firstObject];
}


@end
