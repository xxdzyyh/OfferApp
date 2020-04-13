//
//  SyncAndAsyncVC.m
//  OfferApp
//
//  Created by wangxuefeng on 2020/4/2.
//  Copyright © 2020 com.learn. All rights reserved.
//

#import "SyncAndAsyncVC.h"

@interface SyncAndAsyncVC ()

@end

@implementation SyncAndAsyncVC

- (void)viewDidLoad {
    [super viewDidLoad];

	//	[self syncAndAsync];
	[self test1];
}


- (void)syncAndAsync {
	/**
	 "BUG IN CLIENT OF LIBDISPATCH: dispatch_sync called on queue already owned by current thread"
	
	 dispatch_sync 不会开启新的线程，所以dispatch_sync中的任务会在队列当前所在线程执行。
	 如果这个线程和dispacth_sync语句执行的线程相同，那就会发生死锁。
	 
	 当前是主线程，dispatch_sync和block会发生阻塞。
	 */
//	dispatch_sync(dispatch_get_main_queue(), ^{
//		NSLog(@"%@",[NSThread currentThread]);
//		NSLog(@"%@",@"主队列同步执行");
//	});
//
	/**
	 不是说主队列不能同步执行，而是在主线程里主队列不能同步执行。
	 如果当前不是主线程，可以使用
	 */
	dispatch_async(dispatch_get_global_queue(0, 0), ^{
		dispatch_sync(dispatch_get_main_queue(), ^{
			NSLog(@"%@",[NSThread currentThread]);
			NSLog(@"%@",@"主队列同步执行");
		});
		NSLog(@"111");
	});
	NSLog(@"222");
	/**
	 2020-04-02 14:41:00.782926+0800 OfferApp[4576:679914] 222
	 2020-04-02 14:41:00.799266+0800 OfferApp[4576:679914] <NSThread: 0x60000205a440>{number = 1, name = main}
	 2020-04-02 14:41:00.803161+0800 OfferApp[4576:679914] 主队列同步执行
	 2020-04-02 14:41:00.803825+0800 OfferApp[4576:680024] 111
	 */
}

- (void)test1 {
	__block int a = 0;
	
	while (a<5) {
		dispatch_async(dispatch_get_global_queue(0, 0),^{
			a++;
		});
	}
	// 只能知道a>=5，具体的数值和触发多少次循环是相关的，因为多线程的执行时间是未知的，所以a可以大于5
	NSLog(@"a=%d",a);
}

@end
