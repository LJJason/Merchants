//
//  GFCollectionViewCell.m
//  九宫格
//
//  Created by wgf on 16/9/26.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "GFCollectionViewCell.h"

@implementation GFCollectionViewCell

//- (instancetype)initWithFrame:(CGRect)frame {
//    if (self = [super initWithFrame:frame]) {
//        _imageView = [[UIImageView alloc] init];
//        [self addSubview:_imageView];
//        
//        self.clipsToBounds = YES;
//    }
//    return self;
//}

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
