//
//  TRCheckBox.m
//  TRMerchants
//
//  Created by wgf on 16/10/9.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRCheckBox.h"

#define padding 5
#define setImageSideLength 15
@implementation TRCheckBox

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.exclusiveTouch = YES;
        
        [self setImage:[UIImage imageNamed:@"checkbox1_unchecked"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"checkbox1_checked"] forState:UIControlStateSelected];
        
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:TRColor(101, 202, 97, 1.0) forState:UIControlStateSelected];
        
        [self addTarget:self action:@selector(changeSelectStatus:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
-(void)setDefaultStatu:(BOOL)defaultStatu{
    _defaultStatu = defaultStatu;
    self.selected = defaultStatu;
    
}
-(void)changeSelectStatus:(UIButton*)button{
    self.selected = !self.selected;
    if (_delegate != nil && [_delegate respondsToSelector:@selector(handleAccordingIndex:selected:)]) {
        [_delegate handleAccordingIndex:button.tag selected:self.selected];
    }
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, (CGRectGetHeight(contentRect)-setImageSideLength)/2, setImageSideLength,setImageSideLength ) ;
    
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(setImageSideLength+padding,0 ,CGRectGetWidth(contentRect)-setImageSideLength-padding ,CGRectGetHeight(contentRect)) ;
}
@end
