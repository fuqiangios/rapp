//
//  PickerSelectViewController.h
//  
//
//  Created by qiang.c.fu on 2020/7/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^ReturnValueBlock) (NSArray * dataList);
@interface PickerSelectViewController : UIViewController
@property (nonatomic) NSMutableArray *photoArray;
@property(nonatomic, copy) ReturnValueBlock returnValueBlock;
@property (nonatomic, strong) NSString *typeName;
@end

NS_ASSUME_NONNULL_END
