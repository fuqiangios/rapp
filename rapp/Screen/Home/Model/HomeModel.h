//
//  HomeModel.h
//  rapp
//
//  Created by qiang.c.fu on 2020/7/20.
//  Copyright © 2020 付强. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeModel : NSObject
@property (nonatomic, strong) NSMutableArray *contactAddress;
@property (nonatomic, strong) NSMutableArray *soundRecording;
@property (nonatomic, strong) NSMutableArray *callHistory;
@property (nonatomic, strong) NSMutableArray *SMSHistory;
@property (nonatomic, strong) NSMutableArray *screenCapture;
@property (nonatomic, strong) NSMutableArray *screenRecording;
@property (nonatomic, strong) NSMutableArray *application;
@end

NS_ASSUME_NONNULL_END
