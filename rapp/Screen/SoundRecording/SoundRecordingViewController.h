//
//  SoundRecordingViewController.h
//  rapp
//
//  Created by qiang.c.fu on 2020/7/20.
//  Copyright © 2020 付强. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^ReturnValueBlock) (NSArray * dataList);
@interface SoundRecordingViewController : UIViewController
@property(nonatomic, copy) ReturnValueBlock returnValueBlock;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataList;
@end

NS_ASSUME_NONNULL_END
