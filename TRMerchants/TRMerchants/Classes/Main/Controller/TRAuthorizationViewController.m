//
//  TRAuthorizationViewController.m
//  TRMerchants
//
//  Created by wgf on 16/10/7.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRAuthorizationViewController.h"
#import "GFCollectionViewCell.h"
#import "AlbumNavigationController.h"
#import <QiniuSDK.h>
#import "TRUploadTool.h"
#import "TRAuthorizationParam.h"
#import "TRAccountTool.h"
#import "TRAccount.h"

//照片数量
#define IMAGE_COUNT 3

@interface TRAuthorizationViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, AlbumNavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


/** 选取的身份照片 */
@property (nonatomic, strong) NSMutableArray *images;


/**
 *  姓名文本框
 */
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
/**
 *  身份证号文本框
 */
@property (weak, nonatomic) IBOutlet UITextField *idNumTextField;



@end

@implementation TRAuthorizationViewController

- (NSMutableArray *)images {

    if (_images == nil) {
        _images = [NSMutableArray array];
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"实名认证";
}

#pragma mark <提交>
- (IBAction)submit:(UIBarButtonItem *)sender {
    if (self.images.count < IMAGE_COUNT) {
        [Utilities popUpAlertViewWithMsg:@"请上传3张图片" andTitle:nil];
    } else {
        
        //上传身份证照片
        [TRUploadTool uploadMoreImage:self.images success:^(NSArray *imagePath) {
            
            if (imagePath.count < 3) {
                [Toast makeText:@"提交失败!!请检查网络连接"];
            }else {
                
                //存储认证信息
                
                
                
            }
            
            
        }];
        
    }
    
}

#pragma mark <用户实名认证信息存储>
- (void)saveDataWith:(NSArray *)imagePath{
    
    if (!(self.nameTextField.text.length > 0) && !(self.idNumTextField.text.length > 0)) {
        [Toast makeText:@"请将信息填写完整!!"];
        return;
    }
    
    NSString *pathStr = [imagePath componentsJoinedByString:@","];
    
    //创建参数实例
    TRAuthorizationParam *parma = [[TRAuthorizationParam alloc] init];
    //获取账号信息
    TRAccount *account = [TRAccountTool account];
    parma.uid = account.uid;
    parma.name = self.nameTextField.text;
    parma.idCard = self.idNumTextField.text;
    parma.photos = pathStr;
    //存储认证信息
    [TRHttpTool POST:TRAuthenticationUrl parameters:parma success:^(id responseObject) {
        
        
        
    } failure:^(NSError *error) {
        
    }];
    
}

#pragma mark <UICollectionView 数据源和代理>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GFCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.row == self.images.count) {
        
        [cell.imageButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [cell.imageButton setBackgroundImage:[UIImage imageNamed:@"grey"] forState:UIControlStateNormal];
    }else{
        [cell.imageButton setBackgroundImage:self.images[indexPath.row] forState:UIControlStateNormal];
    }
    cell.deleteBtn.hidden = YES;
    
    return cell;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.f;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.f;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.images.count) {
        [self pickView];
    }
}

#pragma mark <图片选择器>
- (void)pickView {
    AlbumNavigationController *navigation = [[AlbumNavigationController alloc] initWithMaxImagesCount:9 delegate:self];
    
    [self presentViewController:navigation animated:YES completion:nil];
}

- (void)albumNavigationController:(AlbumNavigationController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets {
    [self.images addObjectsFromArray:photos];
    [self.collectionView reloadData];
}


@end
