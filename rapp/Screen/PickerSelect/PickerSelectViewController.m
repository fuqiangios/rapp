//
//  ViewController.m
//  Demo
//
//  Created by 刘威振 on 16/6/27.
//  Copyright © 2016年 刘威振. All rights reserved.
//

#import "PickerSelectViewController.h"
#import "ZZImagePickerController.h"
#import "ZZTestCell.h"

@interface PickerSelectViewController () <UICollectionViewDelegate, UICollectionViewDataSource, ZZImagePickerControllerDelegate>

@property (nonatomic) UICollectionView *collectionView;
@end

@implementation PickerSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(saveAction)];
    [self addCollectionView];
}

-(void) saveAction {
    self.returnValueBlock(self.photoArray);
    [self.navigationController popViewControllerAnimated:true];
}

- (void)addCollectionView {
    UICollectionViewFlowLayout *layout        = [[UICollectionViewFlowLayout alloc] init];
    CGFloat margin                            = 4;
    CGFloat itemLength                        = (UIScreen.mainScreen.bounds.size.width - 2 * margin - 4) / 3 - margin;
    layout.itemSize                           = CGSizeMake(itemLength, itemLength);
    layout.minimumInteritemSpacing            = margin;
    layout.minimumLineSpacing                 = margin;
    self.collectionView                       = [[UICollectionView alloc] initWithFrame:CGRectMake(margin, 0, UIScreen.mainScreen.bounds.size.width - 2*margin, UIScreen.mainScreen.bounds.size.height) collectionViewLayout:layout];
    self.collectionView.contentInset          = UIEdgeInsetsMake(4, 0, 0, 2);
    self.collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, -2);
    self.collectionView.delegate              = self;
    self.collectionView.dataSource            = self;
    self.collectionView.backgroundColor       = [UIColor whiteColor];
    [self.collectionView registerClass:[ZZTestCell class] forCellWithReuseIdentifier:@"ZZTestCell"];
    [self.view addSubview:self.collectionView];
}

- (void)deleteImage:(UIButton *)btn {
    [_photoArray removeObjectAtIndex:btn.tag-10];
    [_collectionView reloadData];
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photoArray.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZZTestCell" forIndexPath:indexPath];
    if (indexPath.row == self.photoArray.count) {
        cell.imageView.image = [UIImage imageNamed:@"AlbumAddBtn"];
        cell.deleteBtn.hidden = YES;
    } else {
        cell.imageView.image = self.photoArray[indexPath.row];
        cell.deleteBtn.hidden = NO;
    }
    cell.deleteBtn.tag = indexPath.item+10;
    [cell.deleteBtn addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.row == self.photoArray.count) {
        ZZImagePickerController *controller = [[ZZImagePickerController alloc] initWithConfigure:nil];
        /**
        ZZImagePickerController *controller2 = [[ZZImagePickerController alloc] initWithConfigure:^(ZZImagePickerConfigure *config) {
            config.allowMaxCount = 9; // 最多允许选择9张图片
            config.allowPickVideo = YES; // 允许选取视频
            config.allowPickOriginal = YES; // 允许显示图片大小
            ...
        }];
         */
        controller.modalPresentationStyle = UIModalPresentationCustom;
        controller.pickDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
    }
}

- (NSMutableArray *)photoArray {
    if (_photoArray == nil) {
        _photoArray = [NSMutableArray array];
    }
    return _photoArray;
}

#pragma mark - ZZImagePickerControllerDelegate

- (void)imagePickerController:(ZZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets infos:(NSArray<NSDictionary *> *)infos {
    if (photos == nil) {
        [picker dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    [self.photoArray addObjectsFromArray:photos];
    [self.collectionView reloadData];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(ZZImagePickerController *)picker {
    NSLog(@"Cancel");
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(ZZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAsset:(PHAsset *)asset {
    [self.photoArray addObject:coverImage];
    [self.collectionView reloadData];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
