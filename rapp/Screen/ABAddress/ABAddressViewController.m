//
//  ABAddressViewController.m
//  rapp
//
//  Created by qiang.c.fu on 2020/7/20.
//  Copyright © 2020 付强. All rights reserved.
//

#import "ABAddressViewController.h"
#import "ABAddressViewModel.h"
#import "ABAddress.h"

@interface ABAddressViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *dataArray;
}
@end

@implementation ABAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    dataArray = [[[ABAddressViewModel alloc] init] getPersonData];
    [self.tableView reloadData];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellID"];
    }
    cell.textLabel.text = ((ABAddress *)dataArray[indexPath.row]).name;
    cell.detailTextLabel.text = ((ABAddress *)dataArray[indexPath.row]).phoneNumbers.firstObject;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArray.count;
}

@end
