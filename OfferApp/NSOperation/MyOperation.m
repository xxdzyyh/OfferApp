//
//  MyOperation.m
//  OfferApp
//
//  Created by wangxuefeng on 2020/5/19.
//  Copyright © 2020 com.learn. All rights reserved.
//

#import "MyOperation.h"

@implementation MyOperation

/**
 如果彻底重写 start 那就需要自己去控制任务执行状态
 isReady
 isExecuting
 isFinished
 isCancelled
 */
- (void)start {
	NSLog(@"MyOperation ----- start");
	
	[super start];
}

/**
 如果只重写main方法，底层控制变更任务执行完成状态，以及任务退出
 */
- (void)main {
	NSLog(@"MyOperation ----- start");
	[super main];
}

@end
