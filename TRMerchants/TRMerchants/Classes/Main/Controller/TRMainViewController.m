//
//  TRMainViewController.m
//  TRMerchants
//
//  Created by wgf on 16/9/21.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRMainViewController.h"
#import "TRGoodsTableViewController.h"
#import "TROrderTableViewController.h"

@interface TRMainViewController ()

@end

@implementation TRMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)rooms {
    
    TRNavigationController *nav = [TRNavigationController viewControllerWtithStoryboardName:@"Goods" identifier:@"TRNavigationController"];
    nav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:nav animated:YES completion:nil];
    
}

- (IBAction)order {
    
    TRNavigationController *nav = [TRNavigationController viewControllerWtithStoryboardName:@"Order" identifier:@"TRNavigationController"];
    nav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:nav animated:YES completion:nil];
    
    
    
    
}


@end
