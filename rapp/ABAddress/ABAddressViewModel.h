//
//  ABAddressViewModel.h
//  rapp
//
//  Created by qiang.c.fu on 2020/7/20.
//  Copyright © 2020 付强. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface ABAddressViewModel : NSObject
@property (nonatomic, strong)NSMutableArray *dataArray;
- (NSArray *)getPersonData;
@end

NS_ASSUME_NONNULL_END
