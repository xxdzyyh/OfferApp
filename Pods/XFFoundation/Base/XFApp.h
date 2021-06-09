//
//  XFApp.h
//  XFFoundation
//
//  Created by xiaoniu on 2018/10/9.
//  Copyright © 2018年 wangxuefeng. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kIsFirstLaunch @"kIsFirstLaunch"

@interface XFApp : NSObject

@property (strong, nonatomic) NSString *buglyKey;
@property (strong, nonatomic) NSString *umengKey;

@property (strong, nonatomic) NSString *accessToken;

+ (NSString *)appName;
+ (NSString *)shortVersion;
+ (NSString *)buildVersion;

@end
