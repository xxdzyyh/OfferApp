//
//  NSString+URL.h
//  XFFoundation
//
//  Created by xiaoniu on 2018/11/16.
//  Copyright © 2018 wangxuefeng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (URL)

/**
 *  URLEncode
 */
- (NSString *)URLEncodedString;

/**
 *  URLDecode
 */
- (NSString *)URLDecodedString;

/**
 NSString创建NSURL

 如果字符串不是以http开头，会加上 @"https:"
 
 @return [NSURL URLWithString:self];
 */
- (NSURL *)URLValue;

@end

NS_ASSUME_NONNULL_END
