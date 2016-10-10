//
//  TRAddCollectionViewCell.m
//  TRMerchants
//
//  Created by wgf on 16/10/9.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRAddCollectionViewCell.h"

@implementation TRAddCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _imageButton.userInteractionEnabled = NO;
    //    _imageView.contentMode = UIViewContentModeCenter;
    [self addSubview:_imageButton];
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageButton.frame = self.bounds;
    
}

@end
