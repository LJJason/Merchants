//
//  TRAddRoomsViewController.m
//  TRMerchants
//
//  Created by wgf on 16/10/7.
//  Copyright © 2016年 wgf. All rights reserved.
//

#import "TRAddRoomsViewController.h"
#import "AlbumNavigationController.h"
#import "TRAddCollectionViewCell.h"
#import "TRRoomImageCollectionViewCell.h"
#import <HUPhotoBrowser.h>
#import "TRTableViewCell.h"

@interface TRAddRoomsViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, AlbumNavigationControllerDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


/** 存储商品图片 */
@property (nonatomic, strong) NSMutableArray *images;

/**
 *  collectionView的约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewConstraint;
/**
 *  checkBox的容器View
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *checkBoxConstraint;

/** collectionView的高度 */
@property (nonatomic, assign) CGFloat height;
/**
 *  容器View
 */
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation TRAddRoomsViewController

- (NSMutableArray *)images {
    if (_images == nil) {
        _images = [NSMutableArray array];
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNav];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark <设置导航条的一些相关属性>
- (void)setupNav{
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
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
}

/**
 *  完成
 */
- (void)done{
    
}

#pragma mark <键盘弹起通知>

- (void)keyboardWillChangeFrame:(NSNotification *)note {
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIView *firstResponder = [keyWindow performSelector:@selector(firstResponder)];
    
    //差值
    CGFloat difference = keyboardFrame.origin.y - firstResponder.y;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.containerView.y = keyboardFrame.origin.y - 10;
    }];
    
    
    
}

#pragma mark <UICollectionView 数据源和代理>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == self.images.count) {
        TRAddCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"add" forIndexPath:indexPath];
        [cell.imageButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [cell.imageButton setBackgroundImage:[UIImage imageNamed:@"grey"] forState:UIControlStateNormal];
        return cell;
    }else{
        TRRoomImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"room" forIndexPath:indexPath];
        cell.imageView.image = self.images[indexPath.row];
        cell.deleteBlock = ^(TRRoomImageCollectionViewCell *aCell){
            
            NSIndexPath *index = [collectionView indexPathForCell:aCell];
            
            [self.images removeObjectAtIndex:index.row];
            [self.collectionView deleteItemsAtIndexPaths:@[index]];
            
        };
        return cell;
    }

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
    }else {
        TRRoomImageCollectionViewCell *cell = (TRRoomImageCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [HUPhotoBrowser showFromImageView:cell.imageView withImages:self.images atIndex:indexPath.row];
    }
}



#pragma mark <图片选择器>
- (void)pickView {
    AlbumNavigationController *navigation = [[AlbumNavigationController alloc] initWithMaxImagesCount:9 delegate:self];
    navigation.navigationBar.barTintColor = [UIColor redColor];
    [self presentViewController:navigation animated:YES completion:nil];
}

- (void)albumNavigationController:(AlbumNavigationController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets {
    [self.images addObjectsFromArray:photos];
    
    NSInteger row = ((self.images.count + 1) % 3 == 0) ? ((self.images.count + 1) / 3) : ((self.images.count + 1) / 3 + 1);
    NSInteger margen = row + 1;
    CGFloat height = row * 100 + margen * 5.0;
    TRLog(@"height %lf", height);
    self.collectionViewConstraint.constant = height;
    self.height = height;
    [self.collectionView reloadData];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

@end
