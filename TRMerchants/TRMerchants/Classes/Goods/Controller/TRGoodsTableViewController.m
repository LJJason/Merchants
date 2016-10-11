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
#import "TRRoomParam.h"
#import "TRAccount.h"
#import "TRAccountTool.h"
#import "TRRoom.h"
#import "TRRoomCell.h"

@interface TRGoodsTableViewController ()<UITableViewDelegate, UITableViewDataSource>

/** 认证状态 */
@property (nonatomic, assign) TRAuthorizationState state;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 房间 */
@property (nonatomic, strong) NSArray *rooms;
/**
 *  当无数据的时候充当背景的
 */
@property (weak, nonatomic) IBOutlet UIView *bgView;


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
    [self loadMoreRoom];
    
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
}


#pragma mark -设置导航条相关
- (void)setupNav{
    TRBackButton *button = [TRBackButton backButtonWithTarget:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.title = @"管理商品";
    
}

- (void)loadMoreRoom{
    
    TRAccount *account = [TRAccountTool account];
    
    TRRoomParam *param = [[TRRoomParam alloc] init];
    param.uid = account.uid;
    [TRProgressTool showWithMessage:@"正在加载..."];
    [TRHttpTool GET:TRRoomUrl parameters:param.mj_keyValues success:^(id responseObject) {
        
        self.rooms = [TRRoom mj_objectArrayWithKeyValuesArray:responseObject[@"rooms"]];
        [TRProgressTool dismiss];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [TRProgressTool dismiss];
    }];
    
}


- (void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.rooms.count == 0) {
        tableView.hidden = YES;
        self.bgView.hidden = NO;
    }else {
        tableView.hidden = NO;
        self.bgView.hidden = YES;
    }
    
    return self.rooms.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TRRoomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rooms"];
    
    cell.room = self.rooms[indexPath.row];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        TRRoom *room = self.rooms[indexPath.row];
        
        [TRProgressTool showWithMessage:@"正在删除.."];
        [TRHttpTool GET:TRDeleteRoomUrl parameters:@{@"ID" : @(room.ID)} success:^(id responseObject) {
            
            NSInteger state = [responseObject[@"state"] integerValue];
            
            [TRProgressTool dismiss];
            if (state == 1) {//删除成功
                [Toast makeText:@"删除成功"];
                
            }else {
                [Toast makeText:@"删除失败, 请检查网络"];
            }
            [self loadMoreRoom];
        } failure:^(NSError *error) {
            [TRProgressTool dismiss];
            [Toast makeText:@"请检查网络连接!"];
        }];
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
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
            [self loadMoreRoom];
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
