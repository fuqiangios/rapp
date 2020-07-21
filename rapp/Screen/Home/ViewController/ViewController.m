//
//  ViewController.m
//  rapp
//
//  Created by qiang.c.fu on 2020/7/19.
//  Copyright © 2020 付强. All rights reserved.
//

#import "ViewController.h"
#import "HomeItemCollectionViewCell.h"
#import "JYEqualCellSpaceFlowLayout.h"
#import "ABAddressViewController.h"
#import <ContactsUI/ContactsUI.h>
#import <Contacts/Contacts.h>
#import "HomeModel.h"
#import "SoundRecordingViewController.h"
#import "ZZImagePickerController.h"
#import "PickerSelectViewController.h"
#import "ScreenRecordManager.h"
#import <ReplayKit/ReplayKit.h>


@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, CNContactPickerDelegate, ScreenRecordDelegate>
{
     CNContactPickerViewController * _peoplePickVC;
    HomeModel *model;
}
@property(nonatomic, strong) UIView *broadcastButton;
@end

NSString *reuseIdentifier = @"HomeItemCollectionViewCell";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"大连睿海-反电信诈骗精灵";
    model = [[HomeModel alloc] init];
    [self setUpCollectionView];
    [self.view addSubview:self.broadcastButton];

}

- (void)setUpCollectionView {
    JYEqualCellSpaceFlowLayout * flowLayout = [[JYEqualCellSpaceFlowLayout alloc]initWithType:AlignWithLeft betweenOfCell:30];

    self.collectionView.collectionViewLayout = flowLayout;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeItemCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];
}

- (UIView *)broadcastButton{
    if (!_broadcastButton) {
        RPSystemBroadcastPickerView *picker = [[RPSystemBroadcastPickerView alloc] initWithFrame:CGRectMake(100, 160, 60, 60)];
        picker.preferredExtension = @"com.finlay.rapp.RecordScreenSetup";
        _broadcastButton = picker;
    }
    return _broadcastButton;
}

- (NSArray *)getCollectionViewItems {
    return [NSArray arrayWithObjects:@"通话录音举报",@"电话本举报",@"通话记录举报",@"短信举报",@"截屏举报",@"录屏举报",@"应用信息举报", nil];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 1) {
        return 1;
    }
    return [self getCollectionViewItems].count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return  2;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.layer.cornerRadius = 5;
    cell.layer.masksToBounds = YES;
    if (indexPath.item == 5) {
        if (@available(iOS 12.0, *)) {
            RPSystemBroadcastPickerView *picker = [[RPSystemBroadcastPickerView alloc] initWithFrame:CGRectMake(100, 160, 60, 60)];
             picker.preferredExtension = @"com.finlay.rapp.RecordScreen";
            UIView *lk = [[UIView alloc] init];
            lk = picker;
            [cell.contentView addSubview:lk];

        } else {
            // Fallback on earlier versions
        }

    }
    if (indexPath.section == 1) {
        cell.name.text = @"上传举报数据";
    } else {
        NSString *name = [self getCollectionViewItems][indexPath.item];
        if (indexPath.item == 0 && model.soundRecording.count > 0) {
            name = [NSString stringWithFormat:@"%@(%lu)",name,(unsigned long)model.soundRecording.count];
        } else if (indexPath.item == 1 && model.contactAddress.count > 0) {
            name = [NSString stringWithFormat:@"%@(%lu)",name,(unsigned long)model.contactAddress.count];
        } else if (indexPath.item == 2 && model.callHistory.count > 0) {
            name = [NSString stringWithFormat:@"%@(%lu)",name,(unsigned long)model.callHistory.count];
        } else if (indexPath.item == 3 && model.SMSHistory.count > 0) {
            name = [NSString stringWithFormat:@"%@(%lu)",name,(unsigned long)model.SMSHistory.count];
        } else if (indexPath.item == 4 && model.screenCapture.count > 0) {
            name = [NSString stringWithFormat:@"%@(%lu)",name,(unsigned long)model.screenCapture.count];
        } else if (indexPath.item == 5 && model.screenRecording.count > 0) {
            if (@available(iOS 12.0, *)) {
                RPSystemBroadcastPickerView *picker = [[RPSystemBroadcastPickerView alloc] initWithFrame:CGRectMake(100, 160, 60, 60)];
                 picker.preferredExtension = @"com.finlay.rapp.RecordScreen";
                UIView *lk = [[UIView alloc] init];
                lk = picker;
                [cell.contentView addSubview:lk];

            } else {
                // Fallback on earlier versions
            }


            name = [NSString stringWithFormat:@"%@(%lu)",name,(unsigned long)model.screenRecording.count];
        } else if (indexPath.item == 6 && model.application.count > 0) {
            name = [NSString stringWithFormat:@"%@(%lu)",name,(unsigned long)model.application.count];
        }
        cell.name.text = name;
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section ==  1) {
        return CGSizeMake((UIScreen.mainScreen.bounds.size.width - 60), (UIScreen.mainScreen.bounds.size.width - 90)/5.5);
    }
    return CGSizeMake((UIScreen.mainScreen.bounds.size.width - 90)/2, (UIScreen.mainScreen.bounds.size.width - 90)/4);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 30;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 30;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(30, 30, 30, 30);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {


    switch (indexPath.item) {
        case 0:
        {
            UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"系统提示" message:@"请前往语音备忘录选择录音->点击'...'选择分享->分享到反电信诈骗精灵" preferredStyle:UIAlertControllerStyleAlert];

            UIAlertAction *alertT = [UIAlertAction actionWithTitle:@"我已分享录音" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                SoundRecordingViewController *vc = [[SoundRecordingViewController alloc] init];
                if (self->model.soundRecording == nil) {
                    vc.dataList = [NSMutableArray array];
                } else {
                    vc.dataList = self->model.soundRecording;
                }
                vc.modalPresentationStyle = UIModalPresentationPopover;
                vc.returnValueBlock = ^(NSArray *dataList){
                    self->model.soundRecording = dataList;
                    NSLog(@"%@",dataList);
                    [self.collectionView reloadData];
                };
                [self presentViewController:vc animated:true completion:nil];
            }];
            UIAlertAction *alertF = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

            }];
                [actionSheet addAction:alertT];
            [actionSheet addAction:alertF];
            [self presentViewController:actionSheet animated:YES completion:nil];
        }
            break;
        case 1: {
            _peoplePickVC = [[CNContactPickerViewController alloc] init];
            _peoplePickVC.delegate = self;
            [self presentViewController:_peoplePickVC animated:true completion:nil];
        }
            break;
        case 2:{
            PickerSelectViewController *picker = [[PickerSelectViewController alloc] init];
            picker.typeName = @"call_history";
            picker.photoArray = model.callHistory;
            picker.returnValueBlock = ^(NSArray *dataList){
                self->model.callHistory = dataList;
                [self.collectionView reloadData];
            };
            [self.navigationController pushViewController:picker animated:YES];
        }
            break;
        case 3:{
            PickerSelectViewController *picker = [[PickerSelectViewController alloc] init];
            picker.typeName = @"sms_history";
            picker.photoArray = model.SMSHistory;
            picker.returnValueBlock = ^(NSArray *dataList){
                self->model.SMSHistory = dataList;
                [self.collectionView reloadData];
            };
            [self.navigationController pushViewController:picker animated:YES];
        }
            break;
        case 4: {
            PickerSelectViewController *picker = [[PickerSelectViewController alloc] init];
            picker.typeName = @"iamge";
            picker.photoArray = model.screenCapture;
            picker.returnValueBlock = ^(NSArray *dataList){
                self->model.screenCapture = dataList;
                [self.collectionView reloadData];
            };
            [self.navigationController pushViewController:picker animated:YES];
        }
            break;
        case 5:{
//            [self recordScreen];
        }
        default:
            break;
    }
}

//获取联系人列表
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContacts:(NSArray<CNContact *> *)contacts {
    NSMutableArray *array = [NSMutableArray array];
    //遍历
    for (CNContact * contact in contacts) {

        //姓名
        NSString * firstName = contact.familyName;
        NSString * lastName = contact.givenName;

        //电话
        NSArray * phoneNums = contact.phoneNumbers;
        CNLabeledValue *labelValue = phoneNums.firstObject;
        NSString *phoneValue = [labelValue.value stringValue];

        NSLog(@"姓名：%@%@ 电话：%@", firstName, lastName, phoneValue);
        NSDictionary *dic = @{@"name":[NSString stringWithFormat:@"%@%@",firstName, lastName],@"phone":phoneValue};
        [array addObject:dic];
    }
    model.contactAddress = array;
    [self.collectionView reloadData];
}

//录屏
- (void)recordScreen {
    [[ScreenRecordManager shareManager] screenRecSuc:^{
        NSLog(@"1");
    } failure:^(SRErrorHandle * _Nonnull error) {
        NSLog(@"2");
    }];
}

//获取应用
- (void)getAllApplication {
    id space = [NSClassFromString(@"LSApplicationWorkspace") performSelector:@selector(defaultWorkspace)];
       NSArray *plugins = [space performSelector:@selector(installedPlugins)];
       NSMutableSet *list = [[NSMutableSet alloc] init];
       for (id plugin in plugins) {
           id bundle = [plugin performSelector:@selector(containingBundle)];
           if (bundle)
               [list addObject:bundle];
       }
       int a = 1;
       for (id plugin in list) {
           NSLog(@"🐒 %d--",a);
           a++;
           NSLog(@"bundleIdentifier =%@", [plugin performSelector:@selector(bundleIdentifier)]);//bundleID

           NSLog(@"applicationDSID =%@", [plugin performSelector:@selector(applicationDSID)]);
           NSLog(@"applicationIdentifier =%@", [plugin performSelector:@selector(applicationIdentifier)]);
           NSLog(@"applicationType =%@", [plugin performSelector:@selector(applicationType)]);
           NSLog(@"dynamicDiskUsage =%@", [plugin performSelector:@selector(dynamicDiskUsage)]);

           NSLog(@"itemID =%@", [plugin performSelector:@selector(itemID)]);
           NSLog(@"itemName =%@", [plugin performSelector:@selector(itemName)]);
           NSLog(@"minimumSystemVersion =%@", [plugin performSelector:@selector(minimumSystemVersion)]);

           NSLog(@"requiredDeviceCapabilities =%@", [plugin performSelector:@selector(requiredDeviceCapabilities)]);
           NSLog(@"sdkVersion =%@", [plugin performSelector:@selector(sdkVersion)]);
           NSLog(@"shortVersionString =%@", [plugin performSelector:@selector(shortVersionString)]);

           NSLog(@"sourceAppIdentifier =%@", [plugin performSelector:@selector(sourceAppIdentifier)]);
           NSLog(@"staticDiskUsage =%@", [plugin performSelector:@selector(staticDiskUsage)]);
           NSLog(@"teamID =%@", [plugin performSelector:@selector(teamID)]);
           NSLog(@"vendorName =%@", [plugin performSelector:@selector(vendorName)]);
       }
       return;
}

@end
