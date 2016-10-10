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
#import "TRAddRoomParam.h"
#import "TRUploadTool.h"
#import "TRAccount.h"
#import "TRAccountTool.h"
#import "TRCheckBox.h"

@interface TRAddRoomsViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, AlbumNavigationControllerDelegate, UIScrollViewDelegate, TRCheckBoxDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


/** 存储商品图片 */
@property (nonatomic, strong) NSMutableArray *images;

/**
 *  collectionView的约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewConstraint;
/**
 *  checkBox的容器View的高度约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *checkBoxConstraint;

/** collectionView的高度 */
@property (nonatomic, assign) CGFloat height;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
/**
 *  房间描述
 */
@property (weak, nonatomic) IBOutlet UITextView *describeTextView;
/**
 *  价格文本框
 */
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
/**
 *  地址文本框
 */
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
/**
 *  联系电话文本框
 */
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
/**
 *  容器View
 */
@property (weak, nonatomic) IBOutlet UIView *checkBoxView;


/** 房间配置信息 */
@property (nonatomic, strong) NSArray *configurations;
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
    self.configurations = @[@"wifi", @"空调", @"洗衣机", @"电脑", @"电视", @"多人"];
    
    //创建复选框
    [self createCheckBox];
}

#pragma mark <创建复选框>
- (void)createCheckBox{
    
    CGFloat checkBoxW = 80;
    CGFloat checkBoxH = 40;
    //最大列
    NSInteger maxCol = 3;
    //左右间距
    CGFloat marginW = (TRScreenW - 20 - maxCol * checkBoxW) / (maxCol + 1);
    //上下间距
    CGFloat marginH = 10;
    
    for (NSInteger i = 0; i < self.configurations.count; i++) {
        //列
        NSInteger col = i % maxCol;
        //行
        NSInteger row = i / maxCol;
        //x坐标
        CGFloat checkBoxX = marginW + col * (checkBoxW + marginW);
        CGFloat checkBoxY = (marginH + checkBoxH) * row;
        
        TRCheckBox *checkBox = [[TRCheckBox alloc]initWithFrame:CGRectMake(checkBoxX, checkBoxY, checkBoxW, checkBoxH)];
        checkBox.backgroundColor = [UIColor yellowColor];
        checkBox.tag = 10001 + i;
        checkBox.delegate = self;
        [checkBox setTitle:self.configurations[i] forState:UIControlStateNormal];
        [self.checkBoxView addSubview:checkBox];
    }
    
    self.checkBoxConstraint.constant = marginH + 2 * checkBoxH;
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
    [self.view endEditing:YES];
    
    if (self.images.count == 0) {
        [Utilities popUpAlertViewWithMsg:@"请至少上传1张图片" andTitle:nil];
    } else {
        
        [TRProgressTool showWithMessage:@"正在提交..."];
        //上房间照片
        [TRUploadTool uploadMoreImage:self.images success:^(NSArray *imagePath) {
            [TRProgressTool dismiss];
            TRLog(@"%zd", imagePath.count);
            if (imagePath.count < self.images.count) {
                
                [TRProgressTool dismiss];
                [Toast makeText:@"提交失败!!请检查网络连接"];
                
            }else {
                //存储认证信息
                [self saveDataWith:imagePath];
            }
            
            
        }];
        
    }
    
    
}

- (void)saveDataWith:(NSArray *)imagePath{
    if (!(self.priceTextField.text.length > 0) && !(self.addressTextField.text.length > 0) && !(self.phoneNumTextField.text.length > 0)) {
        [Toast makeText:@"请将信息填写完整!!"];
        return;
    }
    
    NSInteger price = [self.priceTextField.text integerValue];
    
    if (!price) {
        [Toast makeText:@"价格只能是数字哦!"];
        return;
    }
    
    NSMutableArray *configurationArrM = [NSMutableArray array];
    
    for (UIButton *button in self.checkBoxView.subviews) {
        
        if (button.selected) {
            
            [configurationArrM addObject:[NSString stringWithFormat:@"%zd", button.tag]];
        }
    }
    
    //图片路径
    NSString *pathStr = [imagePath componentsJoinedByString:@","];
    //房间配置字符串
    NSString *configurationStr = [configurationArrM componentsJoinedByString:@","];
    
    //创建参数实例
    TRAddRoomParam *parma = [[TRAddRoomParam alloc] init];
    //获取账号信息
    TRAccount *account = [TRAccountTool account];
    
    parma.uid = account.uid;
    parma.phoneNum = self.phoneNumTextField.text;
    parma.address = self.addressTextField.text;
    parma.photosUrl = pathStr;
    parma.configuration = configurationStr;
    parma.describe = self.describeTextView.text;
    parma.price = price;
    
    //存储认证信息
    [TRHttpTool POST:TRAuthenticationUrl parameters:parma.mj_keyValues success:^(id responseObject) {
        
        TRLog(@"%@", responseObject);
        
    } failure:^(NSError *error) {
        [Toast makeText:@"提交失败!!请检查网络连接"];
    }];
}

#pragma mark <键盘弹起通知>

- (void)keyboardWillChangeFrame:(NSNotification *)note {
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];

    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIView *firstResponder = [keyWindow performSelector:@selector(firstResponder)];
    
    CGFloat maxY = CGRectGetMaxY([firstResponder convertRect:firstResponder.frame toView:keyWindow]);
    CGFloat difference = keyboardFrame.origin.y - maxY;

    CGFloat margin = 0.0;
    
    if (difference < 0) {
        margin = difference;
    }
    
    
    [UIView animateWithDuration:0.25 animations:^{
        self.scrollView.y = margin;
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


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5.f;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
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
    
    NSMutableArray *imageArray = [NSMutableArray array];
    for (int i = 0; i < photos.count; i++) {
        UIImage *temImage = photos[i];
        //压缩图片
        NSData *data = UIImageJPEGRepresentation(temImage, 0.1);
        [imageArray addObject:[UIImage imageWithData:data]];
    }
    
    [self.images addObjectsFromArray:imageArray];
    
    NSInteger row = ((self.images.count + 1) % 3 == 0) ? ((self.images.count + 1) / 3) : ((self.images.count + 1) / 3 + 1);
    NSInteger margen = row + 1;
    CGFloat height = row * 100 + margen * 5.0;
    TRLog(@"height %lf", height);
    self.collectionViewConstraint.constant = height;
    self.height = height;
    [self.collectionView reloadData];
    
}
#pragma mark <scrollView 代理>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark <TRCheckBox 代理>
- (void)handleAccordingIndex:(NSInteger)index selected:(BOOL)select {
    
    
    
}

@end
