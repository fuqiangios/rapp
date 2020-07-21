//
//  ABAddress.h
//  rapp
//
//  Created by qiang.c.fu on 2020/7/20.
//  Copyright © 2020 付强. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface ABAddress : NSObject
@property (nonatomic,strong)NSString  *name;   //姓名
@property(nonatomic, strong) NSArray *phoneNumbers;    //电话号码
@property (nonatomic,strong)NSString *email;    //邮箱
@property (nonatomic,strong)NSData *imgStr;    //头像
@end

NS_ASSUME_NONNULL_END
