//
//  SoundRecordingViewController.m
//  rapp
//
//  Created by qiang.c.fu on 2020/7/20.
//  Copyright © 2020 付强. All rights reserved.
//

#import "SoundRecordingViewController.h"

@interface SoundRecordingViewController ()<UITableViewDelegate, UITableViewDataSource>
@end

@implementation SoundRecordingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame = CGRectMake(30, 100, UIScreen.mainScreen.bounds.size.width - 60, 50);
    [submitBtn setTitle:@"保存" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    submitBtn.backgroundColor = UIColor.redColor;

    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 200)];
    [footerView addSubview:submitBtn];

    self.tableView.tableFooterView = footerView;

    [self.tableView reloadData];
    [self.tableView setEditing:YES animated:YES];
    for (int i = 0; i<self.dataList.count; i++) {
        [self.tableView selectRowAtIndexPath:self.dataList[i] animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
}

- (void)saveAction {
    NSLog(@"%@",self.dataList);
    self.returnValueBlock(self.dataList);
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellID"];
    }

    NSArray *data = [self getSoundRecording];
    cell.textLabel.text = data[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self getSoundRecording].count;
}

//获取录音
- (NSArray *)getSoundRecording {
    NSArray *patchs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);

    // 获取Documents路径
    // [patchs objectAtIndex:0]
    NSString *documentsDirectory = [patchs objectAtIndex:0];
    NSString *fileDirectory = [documentsDirectory stringByAppendingPathComponent:@"sound/"];

    NSArray *files = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:fileDirectory error:nil];
    return files;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%lu",indexPath.row);
    [self.dataList addObject:indexPath];
    NSLog(@"%@",self.dataList);
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.dataList removeObject:indexPath];
}
@end
