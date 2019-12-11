//
//  Question.h
//  OfferFramework
//
//  Created by wangxuefeng on 2019/12/11.
//  Copyright © 2019 wangxuefeng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Question : NSObject

@property (copy  , nonatomic) NSString *uid;
@property (copy  , nonatomic) NSString *content;
@property (assign, nonatomic) NSUInteger type;

- (NSString *)toJsonString;

@end

NS_ASSUME_NONNULL_END
