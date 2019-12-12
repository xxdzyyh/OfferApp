//
//  XFAppDelegate.m
//  FileShareTest
//
//  Created by wangxuefeng on 16/6/8.
//  Copyright © 2016年 wangxuefeng. All rights reserved.
//

#import "XFAppDelegate.h"

@implementation XFAppDelegate

- (NSArray *)plugins {
    
    return [[XFPluginManager sharedXFPluginManager] getAllPlugins];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    for (XFPlugin *obj in [self plugins]) {
        if ([obj respondsToSelector:@selector(application:didFinishLaunchingWithOptions:)]) {
            
            [obj application:application didFinishLaunchingWithOptions:launchOptions];
        }
    }
    
    return YES;
}

#pragma mark - 应用状态转变

- (void)applicationWillResignActive:(UIApplication *)application {
    
    for (XFPlugin *obj in [self plugins]) {
        if ([obj respondsToSelector:@selector(applicationWillResignActive:)]) {
            
            [obj applicationWillResignActive:application];
        }
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application {

    for (XFPlugin *obj in [self plugins]) {
        if ([obj respondsToSelector:@selector(applicationDidEnterBackground:)]) {
            
            [obj applicationDidEnterBackground:application];
        }
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {

    for (XFPlugin *obj in [self plugins]) {
        if ([obj respondsToSelector:@selector(applicationWillEnterForeground:)]) {
            
            [obj applicationWillEnterForeground:application];
        }
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {

    for (XFPlugin *obj in [self plugins]) {
        if ([obj respondsToSelector:@selector(applicationDidBecomeActive:)]) {
            
            [obj applicationDidBecomeActive:application];
        }
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {

    for (XFPlugin *obj in [self plugins]) {
        if ([obj respondsToSelector:@selector(applicationWillTerminate:)]) {
            
            [obj applicationWillTerminate:application];
        }
    }
}

#pragma mark - 应用间交互

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    for (XFPlugin *obj in [self plugins]) {
        if ([obj respondsToSelector:@selector(application:openURL:sourceApplication:annotation:)]) {
            
            [obj application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
        }
    }
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    
    for (XFPlugin *obj in [self plugins]) {
        if ([obj respondsToSelector:@selector(application:openURL:options:)]) {
            
            [obj application:application openURL:url options:options];
        }
    }
    
    return YES;
}

//#pragma mark - 推送相关
//
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
//    
//    for (XFPlugin *obj in [self plugins]) {
//        if ([obj respondsToSelector:@selector(application:didReceiveRemoteNotification:)]) {
//            
//            [obj application:application didReceiveRemoteNotification:userInfo];
//        }
//    }
//}
//
//- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//    
//    for (XFPlugin *obj in [self plugins]) {
//        if ([obj respondsToSelector:@selector(application:didRegisterForRemoteNotificationsWithDeviceToken:)]) {
//            
//            [obj application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
//        }
//    }
//}
//
//- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
//    
//    for (XFPlugin *obj in [self plugins]) {
//        if ([obj respondsToSelector:@selector(application:didReceiveLocalNotification:)]) {
//            
//            [obj application:application didReceiveLocalNotification:notification];
//        }
//    }
//}

- (UIWindow *)window {
    if (_window == nil) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        _window.backgroundColor = [UIColor whiteColor];
    }
    return _window;
}

@end
