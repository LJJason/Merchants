//
//  TRRoomCell.m
//  TRMerchants
//
//  Created by wgf on 16/10/11.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRRoomCell.h"

@interface TRRoomCell ()

/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
/**
 *  描述
 */
@property (weak, nonatomic) IBOutlet UILabel *describeLbl;
/**
 *  销量
 */
@property (weak, nonatomic) IBOutlet UILabel *salesLbl;
/**
 *  收藏量
 */
@property (weak, nonatomic) IBOutlet UILabel *collectionsLbl;
/**
 *  价格
 */
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;


@end

@implementation TRRoomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRoom:(TRRoom *)room {
    _room = room;
    
    
    
}

@end
