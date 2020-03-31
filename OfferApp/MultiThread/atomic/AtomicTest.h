//
//  AtomicTest.h
//  OfferApp
//
//  Created by wangxuefeng on 2020/3/31.
//  Copyright © 2020 com.learn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AtomicTest : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, atomic) NSString *lastName;

@end

NS_ASSUME_NONNULL_END
