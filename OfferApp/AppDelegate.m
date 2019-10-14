//
//  AppDelegate.m
//  OfferApp
//
//  Created by xiaoniu on 2018/10/11.
//  Copyright © 2018年 com.learn. All rights reserved.
//

#import "AppDelegate.h"
#import "SMLagMonitor.h"
#import "SMCallTrace.h"

@interface MyObject<__covariant T> : NSObject 

@property (nonatomic, strong) T obj;

@end

@implementation MyObject


@end

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    [SMCallTrace start];
    
    MyObject<NSNumber *> *obj = [[MyObject alloc] init];
    
    NSLog(@"%@",obj.obj);
    
    [[UIView appearance] setBackgroundColor:[UIColor whiteColor]];
    
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

- (void)applicationDidEnterBackground:(UIApplication *)application {
     [SMCallTrace save];
}

@end
