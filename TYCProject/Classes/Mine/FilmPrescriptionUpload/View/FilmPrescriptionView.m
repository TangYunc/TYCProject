//
//  FilmPrescriptionView.m
//  OnlineHosptial
//
//  Created by tangyunchuan on 2019/1/17.
//  Copyright © 2019 zhangliangyu. All rights reserved.
//

#import "FilmPrescriptionView.h"
#import "TYCTestCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "TZImagePickerController.h"
#import "TZImageManager.h"
#import "TZVideoPlayerController.h"

@interface FilmPrescriptionView ()<TZImagePickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIActionSheetDelegate,UIAlertViewDelegate>
{
    
    
}
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIImageView *sampleImg;//示例图片
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (weak, nonatomic) NSString *maxCountTF; ///< 照片最大可选张数，设置为1即为单选模式
@property (weak, nonatomic) NSString *columnNumberTF;
@property (nonatomic, strong)NSMutableArray *selectedPhotos;
@property (nonatomic, strong)NSMutableArray *selectedAssets;
@property (nonatomic, assign)CGFloat itemWH;
@property (nonatomic, assign)BOOL isSelectOriginalPhoto;
@property (nonatomic, assign)CGFloat margin;

@end

@implementation FilmPrescriptionView

- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = self.viewControler.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.viewControler.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (iOS9Later) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
#pragma clang diagnostic pop
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGB_COLOR_WITH_0x(kWhiteColor);
        self.maxCountTF = @"3";
        self.columnNumberTF = @"4";
        self.selectedPhotos = [NSMutableArray array];
        self.selectedAssets = [NSMutableArray array];
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    //03 创建布局对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.margin = KFloat(6);
    self.itemWH = self.frame.size.height;

    layout.itemSize = CGSizeMake(self.itemWH, self.itemWH);
    layout.minimumInteritemSpacing = self.margin;
    layout.minimumLineSpacing = 0;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.itemWH, self.itemWH) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.alwaysBounceVertical = NO;
    _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _collectionView.scrollEnabled = NO;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    //MARK:在9.0以后可以直接调用方法semanticContentAttribute让UICollectionView又对齐。但是在版本9.0以前不提供semanticContentAttribute方法，隐藏用transform对UICollectionView与cellForItemAtIndexPath方法中的cell进行设置
    if (@available(iOS 9.0, *)) {
        _collectionView.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
    } else {
        // Fallback on earlier versions
        _collectionView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    }
    
    _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [_collectionView registerClass:[TYCTestCell class] forCellWithReuseIdentifier:@"TYCTestCell"];
    [self addSubview:_collectionView];
    
    //sampleImage
    self.sampleImg = [[UIImageView alloc] initWithFrame:CGRectMake(_collectionView.right + self.margin, 0, self.itemWH, self.itemWH)];
    self.sampleImg.layer.borderColor = RGB_COLOR_WITH_0x(kCellLineViewColor).CGColor;
    self.sampleImg.layer.borderWidth = 0.5;
    self.sampleImg.layer.cornerRadius = 5;
    [self addSubview:self.sampleImg];
    self.sampleImg.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageView)];
    [self.sampleImg addGestureRecognizer:tap];
}

-(void)setImageUrl:(NSString *)imageUrl{
    _imageUrl = imageUrl;
    [self updateImageView];
}

-(void)updateImageView{
    [self.sampleImg sd_setImageWithURL:[NSURL URLWithString:self.imageUrl] placeholderImage:[UIImage imageNamed:@"certify_add_image"]];
}

#pragma mark -- 代理协议
#pragma mark -- UICollectionView的代理方法：
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger items = 0;
    if (self.selectedPhotos.count >= 3) {
        items = 3;
    }else{
        items = self.selectedPhotos.count + 1;
    }
    _collectionView.width = items * (self.itemWH + self.margin);
    self.sampleImg.left = _collectionView.right + self.margin;
    self.width = self.sampleImg.right;
    if (self.widthBlock) {
        self.widthBlock(self.width);
    }
    return items;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TYCTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TYCTestCell" forIndexPath:indexPath];
    cell.videoImageView.hidden = YES;
    if (@available(iOS 9.0, *)) {
        DEBUG_LOG(@"在9.0以后可以直接调用方法semanticContentAttribute让UICollectionView又对齐。但是在版本9.0以前不提供semanticContentAttribute方法，隐藏用transform对UICollectionView与cellForItemAtIndexPath方法中的cell进行设置");
    } else {
        // Fallback on earlier versions
        cell.transform = CGAffineTransformMakeScale(-1.0, 1.0);;
    }
    if (indexPath.row == self.selectedPhotos.count) {
        cell.imageView.image = [UIImage imageNamed:@"but_djpf"];
        cell.deleteBtn.hidden = YES;
    } else {
        cell.imageView.image = self.selectedPhotos[indexPath.row];
        cell.deleteBtn.hidden = NO;
    }
    
    cell.deleteBtn.tag = indexPath.row;
    CGFloat deleteBtnWidth = KFloat(22);
    [cell.deleteBtn setImage:[UIImage imageNamed:@"delete_certify_image"] forState:UIControlStateNormal];
    cell.deleteBtn.frame = CGRectMake(self.itemWH - 32, 8, deleteBtnWidth, deleteBtnWidth);
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == self.selectedPhotos.count) {
        BOOL showSheet = YES;
        if (showSheet) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"去相册选择", nil];
#pragma clang diagnostic pop
            [sheet showInView:self];
        } else {
            [self pushImagePickerController];
        }
    } else { // preview photos or video / 预览照片或者视频
        [self pushOtherController:self.selectedPhotos];
    }
}

#pragma mark - TZImagePickerController
- (void)pushImagePickerController {
    if (self.maxCountTF.integerValue < 0) {
        return;
    }
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:self.maxCountTF.integerValue columnNumber:self.columnNumberTF.integerValue delegate:self pushPhotoPickerVc:YES];
    
    
#pragma mark - 四类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = self.isSelectOriginalPhoto;
    
    if (self.maxCountTF.integerValue > 1) {
        // 1.设置目前已经选中的图片数组
        imagePickerVc.selectedAssets = self.selectedAssets; // 目前已经选中的图片数组
    }
    imagePickerVc.allowTakePicture = NO; // 在内部显示拍照按钮
    
    // 2. Set the appearance
    // 2. 在这里设置imagePickerVc的外观
//     imagePickerVc.navigationBar.barTintColor = [UIColor greenColor];
    // imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
//     imagePickerVc.oKButtonTitleColorNormal = [UIColor greenColor];
    imagePickerVc.barItemTextColor = UIColorFromRGBA(0, 122, 255, 1.0);
    
    // 3. Set allow picking video & photo & originalPhoto or not
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = YES;
    
    // imagePickerVc.minImagesCount = 3;
    // imagePickerVc.alwaysEnableDoneBtn = YES;
    
    // imagePickerVc.minPhotoWidthSelectable = 3000;
    // imagePickerVc.minPhotoHeightSelectable = 2000;
#pragma mark - 到这里为止
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
    }];
    
    [self.viewControler presentViewController:imagePickerVc animated:YES completion:nil];
}


#pragma mark - UIImagePickerController

- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS7Later) {
        // 无相机权限 做一个友好的提示
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
#define push @#clang diagnostic pop
        // 拍照之前还需要检查相册权限
    } else if ([[TZImageManager manager] authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        alert.tag = 1;
        [alert show];
    } else if ([[TZImageManager manager] authorizationStatus] == 0) { // 正在弹框询问用户是否允许访问相册，监听权限状态
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            return [self takePhoto];
        });
    } else { // 调用相机
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            self.imagePickerVc.sourceType = sourceType;
            if(iOS8Later) {
                _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            }
            [self.viewControler presentViewController:_imagePickerVc animated:YES completion:nil];
        } else {
            NSLog(@"模拟器中无法打开照相机,请在真机中使用");
        }
    }
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
        tzImagePickerVc.sortAscendingByModificationDate = YES;
        [tzImagePickerVc showProgressHUD];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        // save photo and get asset / 保存图片，获取到asset
        WS(weakSelf);
        [[TZImageManager manager] savePhotoWithImage:image completion:^(NSError *error){
            if (error) {
                [tzImagePickerVc hideProgressHUD];
                NSLog(@"图片保存失败 %@",error);
            } else {
                [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES completion:^(TZAlbumModel *model) {
                    [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
                        [tzImagePickerVc hideProgressHUD];
                        TZAssetModel *assetModel = [models firstObject];
                        if (tzImagePickerVc.sortAscendingByModificationDate) {
                            assetModel = [models lastObject];
                        }
                        [weakSelf.selectedAssets addObject:assetModel.asset];
                        [weakSelf.selectedPhotos addObject:image];
                        [weakSelf.collectionView reloadData];
                    }];
                }];
            }
        }];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - UIActionSheetDelegate

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
#pragma clang diagnostic pop
    if (buttonIndex == 0) { // take photo / 去拍照
        [self takePhoto];
    } else if (buttonIndex == 1) {
        [self pushImagePickerController];
    }
}

#pragma mark - UIAlertViewDelegate

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
#pragma clang diagnostic pop
    if (buttonIndex == 1) { // 去设置界面，开启相机访问权限
        if (iOS8Later) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
    }
}
// The picker should dismiss itself; when it dismissed these handle will be called.
// If isOriginalPhoto is YES, user picked the original photo.
// You can get original photo with asset, by the method [[TZImageManager manager] getOriginalPhotoWithAsset:completion:].
// The UIImage Object in photos default width is 828px, you can set it by photoWidth property.
// 这个照片选择器会自己dismiss，当选择器dismiss的时候，会执行下面的代理方法
// 如果isSelectOriginalPhoto为YES，表明用户选择了原图
// 你可以通过一个asset获得原图，通过这个方法：[[TZImageManager manager] getOriginalPhotoWithAsset:completion:]
// photos数组里的UIImage对象，默认是828像素宽，你可以通过设置photoWidth属性的值来改变它
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    self.selectedPhotos = [NSMutableArray arrayWithArray:photos];
    self.selectedAssets = [NSMutableArray arrayWithArray:assets];
    
    self.isSelectOriginalPhoto = isSelectOriginalPhoto;
    [_collectionView reloadData];
    if (self.block) {
        self.block(self.selectedPhotos);
    }
    // 1.打印图片名字
    [self printAssetsName:assets];
}
#pragma mark - Private

/// 打印图片名字
- (void)printAssetsName:(NSArray *)assets {
    NSString *fileName;
    for (id asset in assets) {
        if ([asset isKindOfClass:[PHAsset class]]) {
            PHAsset *phAsset = (PHAsset *)asset;
            fileName = [phAsset valueForKey:@"filename"];
        } else if ([asset isKindOfClass:[ALAsset class]]) {
            ALAsset *alAsset = (ALAsset *)asset;
            fileName = alAsset.defaultRepresentation.filename;;
        }
        NSLog(@"图片名字:%@",fileName);
    }
}

#pragma mark - Click Event图片中的删除事件
- (void)deleteBtnClik:(UIButton *)sender {
    
    [self.selectedPhotos removeObjectAtIndex:sender.tag];
    [self.selectedAssets removeObjectAtIndex:sender.tag];
    [_collectionView reloadData];
    if (self.block) {
        self.block(self.selectedPhotos);
    }
}

-(void)tapImageView{
    [self pushOtherController:@[self.imageUrl]];
}

- (void)pushOtherController:(NSArray *)photoArray{
    NSLog(@"点击示例图片");
}

@end
