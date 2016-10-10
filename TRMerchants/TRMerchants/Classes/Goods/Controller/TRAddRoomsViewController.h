//
//  TRAddRoomsViewController.h
//  TRMerchants
//
//  Created by wgf on 16/10/7.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRAddRoomsViewController : UIViewController

/** 添加房间成功的回调 */
@property (nonatomic, copy) void (^addRoomSuccess)();

@end
