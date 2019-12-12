//
//  NSString+URL.m
//  XFFoundation
//
//  Created by xiaoniu on 2018/11/16.
//  Copyright © 2018 wangxuefeng. All rights reserved.
//

#import "NSString+URL.h"

@implementation NSString (URL)

/**
 *  URLEncode
 */
- (NSString *)URLEncodedString {
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";
    
    NSString *unencodedString = self;
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}

/**
 *  URLDecode
 */
-(NSString *)URLDecodedString {
    //NSString *decodedString = [encodedString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    
    NSString *encodedString = self;
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)encodedString,
                                                                                                                     CFSTR(""),
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}

- (NSURL *)URLValue {
    if (![self hasPrefix:@"http"]) {
        return [NSURL URLWithString:[NSString stringWithFormat:@"https:%@",self]];
    } else {
        return [NSURL URLWithString:self];
    }
}

@end
