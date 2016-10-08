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
    
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_deleteBtn setImage:[UIImage imageNamed:@"error"] forState:UIControlStateNormal];
    [_deleteBtn addTarget:self action:@selector(deleteCell) forControlEvents:UIControlEventTouchUpInside];
    _deleteBtn.hidden = YES;
    [self addSubview:_deleteBtn];

    self.clipsToBounds = YES;
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageButton.frame = self.bounds;
    [self.deleteBtn sizeToFit];
    
    CGRect frame = _deleteBtn.frame;
    frame.origin.x = self.bounds.size.width - _deleteBtn.bounds.size.width;
    frame.origin.y = 0;
    _deleteBtn.frame = frame;
}

- (void)deleteCell{
    if (self.deleteAction) {
        self.deleteAction();
    }
}

@end
