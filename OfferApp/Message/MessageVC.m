//
//  MessageVC.m
//  OfferApp
//
//  Created by wangxuefeng on 2020/4/29.
//  Copyright © 2020 com.learn. All rights reserved.
//

#import "MessageVC.h"

@interface MessageForwarding : NSObject

- (void)test;

@end

@implementation MessageForwarding

- (void)test {
	NSLog(@"MessageForwarding test");
}

@end

@interface MessageVC ()

@end

@implementation MessageVC

- (void)viewDidLoad {
    [super viewDidLoad];

}


+ (BOOL)resolveClassMethod:(SEL)sel {
	return [super resolveClassMethod:sel];
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
	return [super resolveInstanceMethod:sel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
	if (aSelector == @selector(test)) {
		// 让新的对象接受这个消息，相当于[[MessageForwarding new] performSelector:aSelector]
		return [MessageForwarding new];
	}
	return [super forwardingTargetForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
	
}


@end
