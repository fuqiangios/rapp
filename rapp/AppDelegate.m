//
//  AppDelegate.m
//  rapp
//
//  Created by qiang.c.fu on 2020/7/19.
//  Copyright © 2020 付强. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    [self createCustomFileAtName:@"sound"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths lastObject];
    if (url != nil) {
        NSString *path = [url absoluteString];
        path = [path stringByRemovingPercentEncoding];
        NSMutableString *string = [[NSMutableString alloc] initWithString:path];
        if ([path hasPrefix:@"file:///private"]) {
            [string replaceOccurrencesOfString:@"file:///private" withString:@"" options:NSCaseInsensitiveSearch  range:NSMakeRange(0, path.length)];
        }
        NSArray *tempArray = [string componentsSeparatedByString:@"/"];
        NSString *fileName = tempArray.lastObject;
        NSString *sourceName = @"录音-";

        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/sound/%@%@",sourceName,fileName]];
        if ([fileManager fileExistsAtPath:filePath]) {
            NSLog(@"文件已存在");
//            [SVProgressHUD showErrorWithStatus:@"文件已存在"];
            return YES;
        }
//        [MRTools creatFilePathInManager:sourceName];
        BOOL isSuccess = [fileManager copyItemAtPath:string toPath:filePath error:nil];
        if (isSuccess == YES) {
            NSLog(@"拷贝成功");
//            [SVProgressHUD showSuccessWithStatus:@"文件拷贝成功"];
        } else {
            NSLog(@"拷贝失败");
//            [SVProgressHUD showErrorWithStatus:@"文件拷贝失败"];
        }
        NSLog(@"%@",filePath);
         NSLog(@"%@",string);
    }

    NSLog(@"application:openURL:options:");
    return  YES;
}

- (void)createCustomFileAtName:(NSString *)FileName{

    //获取Document文件
    NSString * docsdir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * locationImageData = [docsdir stringByAppendingPathComponent:FileName];//将需要创建的串拼接到后面

    NSLog(@"rarFilePath路径: %@", locationImageData);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    // fileExistsAtPath 判断一个文件或目录是否有效，isDirectory判断是否一个目录
    BOOL existed = [fileManager fileExistsAtPath:locationImageData isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) ) { // 如果文件夹不存在
        /* createDirectoryAtPath:withIntermediateDirectories:attributes:error:
         * 参数1：创建的文件夹的路径
         * 参数2：是否创建媒介的布尔值，一般为YES
         * 参数3: 属性，没有就置为nil
         * 参数4: 错误信息
         */
        [fileManager createDirectoryAtPath:locationImageData withIntermediateDirectories:YES attributes:nil error:nil];
    }
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentCloudKitContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentCloudKitContainer alloc] initWithName:@"rapp"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
