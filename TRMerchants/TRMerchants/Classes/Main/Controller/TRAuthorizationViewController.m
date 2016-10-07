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

@interface TRAuthorizationViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, AlbumNavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


/** 图片 */
@property (nonatomic, strong) NSMutableArray *images;


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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GFCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.row == self.images.count) {
        cell.imageView.contentMode = UIViewContentModeCenter;
        cell.imageView.image = [UIImage imageNamed:@"add"];
    }else{
        cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
        cell.imageView.image = self.images[indexPath.row];
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

- (void)pickView {
    AlbumNavigationController *navigation = [[AlbumNavigationController alloc] initWithMaxImagesCount:9 delegate:self];
    
    [self presentViewController:navigation animated:YES completion:nil];
}

- (void)albumNavigationController:(AlbumNavigationController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets {
    [self.images addObjectsFromArray:photos];
    [self.collectionView reloadData];
}


@end
