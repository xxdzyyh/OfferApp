//
//  XFRequestQueue.m
//  CTQProject
//
//  Created by wangxuefeng on 16/6/21.
//  Copyright © 2016年 code. All rights reserved.
//

#import "XFRequestQueue.h"
#import "XFRequest.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

@interface XFRequestQueue()

@property (strong, nonatomic) NSMutableArray *requests;

@end


@implementation XFRequestQueue

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = name;
    }
    return self;
}

- (id)initWithName:(NSString*)name
            target:(id)target
     startSelector:(SEL)startSelector
   successSelector:(SEL)successSelector
   failureSelector:(SEL)failureSelector
    finishSelector:(SEL)finishSelector {
    self = [super init];
    if (self) {
        _name = name;
        _target = target;
        _requestStartSelector = startSelector;
        _requestFinishSelector = finishSelector;
        _requestFailureSelector = failureSelector;
        _requestSuccessSelector = successSelector;
    }
    return self;
}

- (void)push:(XFRequest *)request {
    if(request == nil) {
        return;
    }
    @synchronized (self) {
        [self.requests addObject:request];
        
        if (self.requests.count == 1) {
            [self notifyRequestStart];
            [self execute];
        }
    }
}

- (void)pause {
    
}

- (void)cancelRequest:(XFRequest *)request {
    for (XFRequest *obj in self.requests) {
        if([obj isEqual:request]) {
            [self.requests removeObject:obj];
        }
    }
}

- (void)cancelAllRequests {
    [self.requests removeAllObjects];
    [self notifyRequestFinish];
}

- (void)execute {
    @synchronized (self) {
        XFRequest * request = nil;
        request = [self.requests firstObject];
        if (request == nil) {
            return;
        }
        [request execute:^(XFRequest *request, ResponseStatus status) {
            if (status == ResponseStatusSuccess) {
                [self.requests removeObject:request];
                if (self.requests.count == 0) {
                    [self notifyRequestFinish];
                } else {
                    [self execute];
                }
            } else {
                if (self.target && [self.target respondsToSelector:self.requestFailureSelector]) {
                    NSNumber *retry = [self.target performSelector:self.requestFailureSelector withObject:@(status)];
                    if (retry.boolValue) {
                        [self pause];
                    } else {
                        [self.requests removeObject:request];
                        [self execute];
                    }
                }
            }
        }];
    }
}

// 队列里所有的请求都执行完了
- (void)notifyRequestFinish {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.target && [self.target respondsToSelector:self.requestFinishSelector]) {
            [self.target performSelector:self.requestFinishSelector];
        }
    });
}

// 队列开始执行
- (void)notifyRequestStart {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.target && [self.target respondsToSelector:self.requestStartSelector]) {
            [self.target performSelector:self.requestStartSelector];
        }
    });
}

// 某个请求执行成功
- (void)notifyRequestSuccess {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.target && [self.target respondsToSelector:self.requestSuccessSelector]) {
            [self.target performSelector:self.requestSuccessSelector];
        }}
    );
}

// 某个请求执行失败
- (void)notifyRequestFailure {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.target && [self.target respondsToSelector:self.requestFailureSelector]) {
            [self.target performSelector:self.requestFailureSelector];
        }
    });
}

#pragma mark - settter & getter

- (NSMutableArray *)requests {
    if (_requests == nil) {
        _requests = [NSMutableArray array];
    }
    return _requests;
}

- (void)dealloc {
   
}

@end

#pragma clang diagnostic pop
