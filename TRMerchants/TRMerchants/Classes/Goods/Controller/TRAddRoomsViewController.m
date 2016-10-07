//
//  TRAddRoomsViewController.m
//  TRMerchants
//
//  Created by wgf on 16/10/7.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRAddRoomsViewController.h"

@interface TRAddRoomsViewController ()

@end

@implementation TRAddRoomsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"添加新的房间";
    
    UIButton *rightBtn = [[UIButton alloc] init];
    [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    rightBtn.bounds = CGRectMake(0, 0, 70, 30);
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

/**
 *  完成
 */
- (void)done{
    
}


@end
