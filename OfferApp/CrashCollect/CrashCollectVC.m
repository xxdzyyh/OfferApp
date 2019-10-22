//
//  CrashCollectVC.m
//  OfferApp
//
//  Created by xiaoniu on 2019/3/21.
//  Copyright © 2019 com.learn. All rights reserved.
//

#import "CrashCollectVC.h"

@interface CrashCollectVC ()

@end

@implementation CrashCollectVC

static NSUncaughtExceptionHandler *handle;

- (void)viewDidLoad {
    [super viewDidLoad];

    handle = NSGetUncaughtExceptionHandler();
    
    NSSetUncaughtExceptionHandler(&crashExceptionHandler);
    
    signal(SIGABRT, signalExceptionHandler);
    signal(SIGILL, signalExceptionHandler);
    signal(SIGSEGV, signalExceptionHandler);
    signal(SIGFPE, signalExceptionHandler);
    signal(SIGBUS, signalExceptionHandler);
    signal(SIGPIPE, signalExceptionHandler);
}

void crashExceptionHandler(NSException *exception) {
    NSArray *callStack = [exception callStackSymbols];
    NSString *reson = [exception reason];
    NSString *name = [exception name];
    
    NSLog(@"%@",callStack);
    NSLog(@"%@",reson);
    NSLog(@"%@",name);
    
    // 如果已经有其他的服务注册了handler, exception 也让它处理一下
    if (handle) {
        handle(exception);
    }
    
    // save
}

void signalExceptionHandler(int signal) {
    NSArray *callStack = [CrashCollectVC backtrace];
    NSLog(@"信号捕获崩溃，堆栈信息：%@",callStack);
    NSString *name = @"wwww";
    NSString *reason = [NSString stringWithFormat:@"signal %d was raised",signal];
}

+ (NSArray *)backtrace {
    return nil;
}

@end
