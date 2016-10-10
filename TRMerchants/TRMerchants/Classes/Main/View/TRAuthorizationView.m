//
//  TRAuthorizationView.m
//  TRMerchants
//
//  Created by wgf on 16/10/8.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRAuthorizationView.h"

@interface TRAuthorizationView ()

@property (weak, nonatomic) IBOutlet UIButton *againBtn;




@end



@implementation TRAuthorizationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    self.againBtn.layer.cornerRadius = 5;
}

+ (instancetype)authorizationView{
    return [[[NSBundle mainBundle] loadNibNamed:@"TRAuthorizationView" owner:nil options:nil] firstObject];
}
- (IBAction)againCommit {
    
    if (self.reloadBlock) {
        self.reloadBlock();
    }
    
    [TRProgressTool showWithMessage:@"正在加载..."];
    
    //延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
        
        [TRProgressTool dismiss];
    });
    
    
}


@end
