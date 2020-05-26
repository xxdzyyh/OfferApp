//
//  OperationVC.m
//  OfferApp
//
//  Created by wangxuefeng on 2020/5/19.
//  Copyright © 2020 com.learn. All rights reserved.
//

#import "OperationVC.h"
#import "MyOperation.h"

@interface OperationVC ()

@end

@implementation OperationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[self operationQueue];
}

- (void)useBlockOperation {
	NSBlockOperation *opt = [NSBlockOperation blockOperationWithBlock:^{
		NSLog(@"%@-----%@",[NSThread currentThread],@"1111");
	}];
	
	[opt addExecutionBlock:^{
		NSLog(@"%@-----%@",[NSThread currentThread],@"2222");
	}];
	
	[opt addExecutionBlock:^{
		NSLog(@"%@-----%@",[NSThread currentThread],@"3333");
	}];
	
	opt.completionBlock = ^{
		NSLog(@"NSBlockOperation completionBlock");
	};
	
	NSLog(@"isFinished-------%d",opt.isFinished);
	NSLog(@"isCancelled-------%d",opt.isCancelled);
	NSLog(@"isAsynchronous-------%d",opt.isAsynchronous);

	/**
	 cancel后再调用start，block不会执行
	 [opt cancel];
	 */
	
	NSLog(@"%@",opt.executionBlocks);

	/**
	 // crash
	 [opt setValue:@0 forKey:@"cancelled"];
	 */
	/**
	 
	 */
	[opt start];
				
	NSLog(@"isFinished-------%d",opt.isFinished);
	NSLog(@"isCancelled-------%d",opt.isCancelled);
	NSLog(@"isAsynchronous-------%d",opt.isAsynchronous);
}

- (void)operationDependency {
	NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
		NSLog(@"%@-----%@",[NSThread currentThread],@"1111");
	}];
	
	NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
		NSLog(@"%@-----%@",[NSThread currentThread],@"2222");
	}];
	
	[op2 addDependency:op1];
	
	/**
	 不调用 [op1 start]; 直接调用 [op2 start]; 会crash，因为 op2没有准备好
	 */
	
	[op1 start];
	[op2 start];
}

- (void)operationQueue {
	NSOperationQueue *queue = [[NSOperationQueue alloc] init];
	
	MyOperation *op1 = [MyOperation blockOperationWithBlock:^{
		NSLog(@"%@-----%@",[NSThread currentThread],@"1111");
	}];
	
	MyOperation *op2 = [MyOperation blockOperationWithBlock:^{
		NSLog(@"%@-----%@",[NSThread currentThread],@"2222");
	}];
	
	[op1 addDependency:op2];
	
	// 进队列后自动执行 -[NSOperation start]
	[queue addOperation:op1];
	[queue addOperation:op2];
}

@end
