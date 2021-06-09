//
//  XFRequestQueue.h
//  CTQProject
//
//  Created by wangxuefeng on 16/6/21.
//  Copyright © 2016年 code. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XFRequest,XFRequestQueue;

@interface XFRequestQueue : NSObject

- (instancetype)initWithName:(NSString *)name;

@property (copy, nonatomic) NSString *name;
@property (weak, nonatomic) id target;

@property (assign, nonatomic) SEL requestStartSelector;
@property (assign, nonatomic) SEL requestFailureSelector;
@property (assign, nonatomic) SEL requestSuccessSelector;
@property (assign, nonatomic) SEL requestFinishSelector;

/**
 *
 *
 *  @param name            名字
 *  @param target          target
 *  @param startSelector   队列中开始有请求被执行
 *  @param successSelector 单个请求执行成功
 *  @param failureSelector 单个请求执行失败
 *  @param finishSelector  队列中全部请求执行完毕
 *
 *  @return
 */
- (id)initWithName:(NSString*)name
            target:(id)target
     startSelector:(SEL)startSelector
   successSelector:(SEL)successSelector
   failureSelector:(SEL)failureSelector
    finishSelector:(SEL)finishSelector;

- (void)push:(XFRequest *)request;
- (void)cancelAllRequests;
- (void)execute;

@end
