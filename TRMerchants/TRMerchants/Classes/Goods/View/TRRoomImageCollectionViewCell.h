//
//  TRRoomImageCollectionViewCell.h
//  TRMerchants
//
//  Created by wgf on 16/10/9.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRRoomImageCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

/** 点击右上角删除按钮 */
@property (nonatomic, copy) void (^deleteBlock)(TRRoomImageCollectionViewCell *aCell) ;

@end
