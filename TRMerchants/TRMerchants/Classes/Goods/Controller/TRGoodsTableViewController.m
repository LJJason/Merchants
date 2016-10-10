//
//  TRGoodsTableViewController.m
//  TRMerchants
//
//  Created by wgf on 16/10/7.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRGoodsTableViewController.h"
#import "TRBackButton.h"
#import "TRAuthorizationStateTool.h"
#import "TRAddRoomsViewController.h"

@interface TRGoodsTableViewController ()<UITableViewDelegate, UITableViewDataSource>

/** 认证状态 */
@property (nonatomic, assign) TRAuthorizationState state;

@end

@implementation TRGoodsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //设置导航条相关
    [self setupNav];
    [TRProgressTool showWithMessage:@"加载中..."];
    [TRAuthorizationStateTool authorizationStateWithSuccess:^(TRAuthorizationState state) {
        self.state = state;
        [TRProgressTool dismiss];
    } failure:^{
        [TRProgressTool dismiss];
    }];
    
}


#pragma mark -设置导航条相关
- (void)setupNav{
    TRBackButton *button = [TRBackButton backButtonWithTarget:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.title = @"管理商品";
    
}

- (void)loadMoreRoom{
    
    //[TRHttpTool GET:<#(NSString *)#> parameters:<#(id)#> success:<#^(id responseObject)success#> failure:<#^(NSError *error)failure#>];
    
}


- (void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rooms"];
    
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

- (IBAction)addGoodsBtn {
    
    if (self.state == TRAuthorizationStateOK) {//已认证商家
        
        TRAddRoomsViewController *addRoomVc = [TRAddRoomsViewController viewControllerWtithStoryboardName:@"Goods" identifier:@"TRAddRoomsViewController"];
        
        //房间添加成功回调
        addRoomVc.addRoomSuccess = ^{
            
        };
        
        [self.navigationController pushViewController:addRoomVc animated:YES];
        
    }else if(self.state == 0){
        [Toast makeText:@"请检查网络连接!!"];
        return;
    }else {//未认证商家
        [Toast makeText:@"请先在设置中完成实名认证, 如果已经提交, 请等待审核完成!!"];
        return;
    }
    
}

@end
