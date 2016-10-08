//
//  GFCollectionViewCell.h
//  九宫格
//
//  Created by wgf on 16/9/26.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFCollectionViewCell : UICollectionViewCell

/** 图片 */
@property (nonatomic, strong) UIButton *imageButton;


/** 右上角的删除按钮 */
@property (nonatomic, strong) UIButton *deleteBtn;

/** block */
@property (nonatomic, copy) void (^deleteAction)();

@end
