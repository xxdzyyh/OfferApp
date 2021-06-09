//
//  MethodExchangeVC.m
//  OfferApp
//
//  Created by MAC on 2021/3/24.
//  Copyright © 2021 com.learn. All rights reserved.
//

#import "MethodExchangeVC.h"
#import <objc/runtime.h>

static void (*OriginalNSCFLocalDataTaskResume)(id, SEL);
static void UTExtNSCFLocalDataTaskResume(id self, SEL _cmd) {
    NSLog(@"UTExtNSCFLocalDataTaskResume %@ %s",self,sel_getName(_cmd));
    OriginalNSCFLocalDataTaskResume(self, _cmd);
}

static void (*OriginalNSCFLocalDataTaskResume1)(id, SEL);
static void UTExtNSCFLocalDataTaskResume1(id self, SEL _cmd) {
    NSLog(@"UTExtNSCFLocalDataTaskResume1 %@ %s",self,sel_getName(_cmd));
    OriginalNSCFLocalDataTaskResume1(self, _cmd);
}

static bool isReject = NO;

@interface MethodExchangeVC ()

@end

@implementation MethodExchangeVC

+ (NSURLSession *)sharedURLSession
{
    static NSURLSession *sharedSession = nil;
    @synchronized(self) {
        if (sharedSession == nil) {
            NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
            sessionConfig.timeoutIntervalForRequest = 30.0;
            sharedSession = [NSURLSession sessionWithConfiguration:sessionConfig];
        }
    }
    return sharedSession;
}

//+ (void)load {
//    [self test];
//    [self test2];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
        
    if (!isReject) {
        isReject = YES;
        [MethodExchangeVC test];
    }
    
    // Do any additional setup after loading the view.
    NSURLRequest *requeset = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    [[[MethodExchangeVC sharedURLSession] dataTaskWithRequest:requeset completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    }] resume];
}

+ (void)test {
    Class class = NSClassFromString(@"__NSCFLocalDataTask");
    SEL originalSelector = @selector(resume);
    IMP replacement = (IMP)UTExtNSCFLocalDataTaskResume;
    IMP* store = (IMP*)&OriginalNSCFLocalDataTaskResume;
    IMP originalImp = NULL;
    Method method = class_getInstanceMethod(class, originalSelector);
    if (method)
    {
        const char* type = method_getTypeEncoding(method);
        originalImp = class_replaceMethod(class, originalSelector, replacement, type);
        if (!originalImp)
        {
            originalImp = method_getImplementation(method);
        }
    }
    if (originalImp && store)
    {
        *store = originalImp;
    }
}

+ (void)test1 {
    Class class = NSClassFromString(@"__NSCFLocalDataTask");
    SEL originalSelector = @selector(resume);
    IMP replacement = (IMP)UTExtNSCFLocalDataTaskResume1;
    IMP* store = (IMP*)&OriginalNSCFLocalDataTaskResume1;
    IMP originalImp = NULL;
    Method method = class_getInstanceMethod(class, originalSelector);
    if (method)
    {
        const char* type = method_getTypeEncoding(method);
        originalImp = class_replaceMethod(class, originalSelector, replacement, type);
        if (!originalImp)
        {
            originalImp = method_getImplementation(method);
        }
    }
    if (originalImp && store)
    {
        *store = originalImp;
    }
}

+ (void)test2 {
    Class class = NSClassFromString(@"__NSCFLocalDataTask");

    Method method = class_getInstanceMethod(self, @selector(resume_DTX));
    if (method) {
        const char* type = method_getTypeEncoding(method);
        IMP originalImp = method_getImplementation(method);
        class_addMethod(class, @selector(resume_DTX), originalImp , type);
        method_exchangeImplementations(class_getInstanceMethod(class, @selector(resume)),class_getInstanceMethod(class, @selector(resume_DTX)));
    }
}

- (void)resume_DTX {
    NSLog(@"resume_DTX");
    [self performSelector:@selector(resume_DTX)];
}

@end
