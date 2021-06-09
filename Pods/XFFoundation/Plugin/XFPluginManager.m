//
//  XFPluginManager.m
//  FileShareTest
//
//  Created by wangxuefeng on 16/6/7.
//  Copyright © 2016年 wangxuefeng. All rights reserved.
//

#import "XFPluginManager.h"

@interface XFPluginManager () 

@property (strong, nonatomic) NSMutableDictionary *plugins;

@end


@implementation XFPluginManager

SYNTHESIZE_SINGLETON_FOR_CLASS(XFPluginManager);

- (void)addPlugin:(XFPlugin *)plugin withName:(NSString *)name {
    
    if (_plugins == nil) {
        _plugins = [NSMutableDictionary dictionary];
    }

    NSAssert(plugin != nil, @"为什么要注册一个空的plugin");
    
    [_plugins setObject:plugin forKey:name];
}

- (XFPlugin *)pluginWithName:(NSString *)name {
    
    id obj = [_plugins objectForKey:name];
    
    return obj;
}

- (NSArray *)getAllPlugins {
    
    return _plugins.allValues;
}

@end
