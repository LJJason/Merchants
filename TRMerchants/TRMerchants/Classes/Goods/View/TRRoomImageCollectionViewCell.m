//
//  TRRoomImageCollectionViewCell.m
//  TRMerchants
//
//  Created by wgf on 16/10/9.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRRoomImageCollectionViewCell.h"

@implementation TRRoomImageCollectionViewCell

- (IBAction)deleteBtnClick {
    if (self.deleteBlock) {
        self.deleteBlock(self);
    }

}


@end
