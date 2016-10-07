//
//  TRSettingTableViewController.m
//  TRMerchants
//
//  Created by wgf on 16/10/7.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRSettingTableViewController.h"
#import "TRBackButton.h"

@interface TRSettingTableViewController ()

@end

@implementation TRSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    
}

- (void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)setupNav{
    TRBackButton *button = [TRBackButton backButtonWithTarget:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.title = @"设置";
}


#pragma mark - Table view data source
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
