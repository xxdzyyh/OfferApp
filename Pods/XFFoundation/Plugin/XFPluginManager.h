//
//  XFPluginManager.h
//  FileShareTest
//
//  Created by wangxuefeng on 16/6/7.
//  Copyright © 2016年 wangxuefeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"
#import "XFPlugin.h"

@interface XFPluginManager : NSObject <UIApplicationDelegate>

DECLARE_SINGLETON_FOR_CLASS(XFPluginManager);

/**
 *  已经安装的所有插件
 */
- (NSArray *)getAllPlugins;

/**
 *  添加插件
 *
 *  @param name 插件名称
 */
- (void)addPlugin:(XFPlugin *)plugin withName:(NSString *)name;

/**
 *  获取插件
 *
 *  @param name 插件名称
 *
 *  @return 依据名称对已添加的插件进行查找，如果名称能匹配，返回这个plugin，否则为空
 */
- (XFPlugin *)pluginWithName:(NSString *)name;


@end
