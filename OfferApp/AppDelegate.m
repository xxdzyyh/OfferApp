//
//  AppDelegate.m
//  OfferApp
//
//  Created by xiaoniu on 2018/10/11.
//  Copyright © 2018年 com.learn. All rights reserved.
//

#import "AppDelegate.h"


@interface MyObject<__covariant T> : NSObject 

@property (nonatomic, strong) T obj;

@end

@implementation MyObject


@end

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    MyObject<NSNumber *> *obj = [[MyObject alloc] init];
    
	[[NSURLCache sharedURLCache] setMemoryCapacity:10 * 1024 * 1024];
	[[NSURLCache sharedURLCache] setDiskCapacity:1024 * 1024 * 10];
	
    NSLog(@"%@",obj.obj);

    return YES;
}

- (void)test {
    
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), 
                                                  kCFRunLoopAllActivities, 
                                                  YES, 0,
                                                  ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity){
                                                      
                                                      switch (activity) {
                                                          case kCFRunLoopEntry:
                                                              NSLog(@"即将进入runloop");
                                                              break;
                                                          case kCFRunLoopBeforeTimers:
                                                              NSLog(@"即将处理timer事件");
                                                              break;
                                                          case kCFRunLoopBeforeSources:
                                                              NSLog(@"即将处理source事件");
                                                              break;
                                                          case kCFRunLoopBeforeWaiting:
                                                              NSLog(@"即将进入睡眠");
                                                              
                                                              //                                                   _objc_autoreleasePoolPrint();
                                                              
                                                              break;
                                                          case kCFRunLoopAfterWaiting:
                                                              NSLog(@"被唤醒");
                                                              break;
                                                          case kCFRunLoopExit:
                                                              NSLog(@"runloop退出");
                                                              break;
                                                              
                                                          default:
                                                              break; 
                                                      }
                                                      
                                                  });
    
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopCommonModes);
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
	NSLog(@"%s",__func__);
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	NSLog(@"%s",__func__);
}

- (void)applicationWillResignActive:(UIApplication *)application {
	NSLog(@"%s",__func__);
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	NSLog(@"%s",__func__);
}

- (void)applicationWillTerminate:(UIApplication *)application {
	NSLog(@"%s",__func__);
}


@end
