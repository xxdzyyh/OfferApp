//
//  NSTimerCycleRetainVC.m
//  OfferApp
//
//  Created by wangxuefeng on 2020/6/2.
//  Copyright © 2020 com.learn. All rights reserved.
//

#import "NSTimerCycleRetainVC.h"

@protocol MyProxyDelegate <NSObject>

- (void)timerFunc;

@end

@interface MyProxy : NSObject <MyProxyDelegate>

@property (weak, nonatomic) id<MyProxyDelegate> delegate;

@end

@implementation MyProxy

- (void)timerFunc {
	NSLog(@"MyProxy timerFunc");
	[self.delegate timerFunc];
}

- (void)dealloc {
	NSLog(@"MyProxy dealloc");
}

@end

@interface NSTimerCycleRetainVC () <MyProxyDelegate>

/// 这里使用weak并不能起到任何作用，因为[NSRunLoop currentRunLoop]会持有timer
@property (weak, nonatomic) NSTimer *timer;

@end

@implementation NSTimerCycleRetainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[self startTimer];
}

- (void)startTimer {
	/**
	 // timer会持有它的target，也就是self
	 NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerFunc) userInfo:nil repeats:YES];

	 self.timer = timer;

	 // [NSRunLoop currentRunLoop] 会持有timer，self使用weak没有持有timer也会造成循环引用，self无法释放
	 [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
	 */
	
	MyProxy *proxy = [MyProxy new];
	proxy.delegate = self;
	
	NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:proxy selector:@selector(timerFunc) userInfo:nil repeats:YES];
	
	// 必须维持一个引用用来废弃timer
	self.timer = timer;
	[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (void)timerFunc {
	NSLog(@"timer da da da");
}

- (void)dealloc {
	// 将timer移除Runloop
	[self.timer invalidate];
	NSLog(@"NSTimerCycleRetainVC dealloc");
}

@end
