//
//  AppDelegate.h
//  rapp
//
//  Created by qiang.c.fu on 2020/7/19.
//  Copyright © 2020 付强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentCloudKitContainer *persistentContainer;
@property (nonatomic, strong) UIWindow *window;

- (void)saveContext;


@end

