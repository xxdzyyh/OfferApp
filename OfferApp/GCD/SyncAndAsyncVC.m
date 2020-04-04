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
    // Do any additional setup after loading the view.

	[self syncAndAsync];
}


- (void)syncAndAsync {

	/**
	  "BUG IN CLIENT OF LIBDISPATCH: dispatch_sync called on queue already owned by current thread"
	
	 当前是主线程，在主队列做同步操作会阻塞主线程。
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

@end
