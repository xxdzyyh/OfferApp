//
//  MessageVC.m
//  OfferApp
//
//  Created by wangxuefeng on 2020/4/29.
//  Copyright © 2020 com.learn. All rights reserved.
//

#import "MessageVC.h"
#import <objc/runtime.h>
#import <objc/message.h>
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

	[self performSelector:@selector(test)];
}

- (void)someMethod {
	NSLog(@"%s",__func__);
}


+ (BOOL)resolveClassMethod:(SEL)sel {
	return [super resolveClassMethod:sel];
}

/**
 方法转发的三个步骤
 
 1. +[NSObject resolveInstanceMethod:]
 2. -[NSObject forwardingTargetForSelector:]
 3. -[NSObject methodSignatureForSelector:] 和 -[NSOjbect forwardInvocation:]
 
 在方法1里怎么处理呢？动态添加方法来解决
 在方法2里怎么处理呢？让其他类实例去处理，只能转发给一个对象
 在方法3里怎么处理呢？方法3需要先重写methodSignatureForSelector，然后可以转发给多个对象
 
 方法1和方法3都改变了这个类的行为，相比较而言，使用方法2来拦截
 */

// 1
+ (BOOL)resolveInstanceMethod:(SEL)sel {
	NSLog(@"%s----%@",__func__,NSStringFromSelector(sel));
	
	IMP imp = imp_implementationWithBlock(^{
		NSLog(@"runtime add test");
	});
	
	class_addMethod(self, NSSelectorFromString(@"test"), imp, "v@:");
	
	return [super resolveInstanceMethod:sel];
}

// 2
- (id)forwardingTargetForSelector:(SEL)aSelector {
	NSLog(@"%s----%@",__func__,NSStringFromSelector(aSelector));
	//	if (aSelector == @selector(test)) {
//		// 让新的对象接受这个消息，相当于[[MessageForwarding new] performSelector:aSelector]
//		// 这里做了l处理，forwardInvocation 就不会继续调用了
//		return [MessageForwarding new];
//	}
	return [super forwardingTargetForSelector:aSelector];
}

// 3

/**
 没有实现 methodSignatureForSelector 就不会调用 forwardInvocation
 */
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
	NSLog(@"%s----%@",__func__,NSStringFromSelector(aSelector));
	if (aSelector == @selector(test)) {
		NSMethodSignature *sig = [NSMethodSignature signatureWithObjCTypes:"v@:"];
		
		return sig;
	} else {
		return [super methodSignatureForSelector:aSelector];
	}
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
	NSLog(@"%s----%@",__func__,NSStringFromSelector(anInvocation.selector));
	NSLog(@"%@",anInvocation);
	
	if (anInvocation.selector == @selector(test)) {
		id obj1 = [MessageForwarding new];
		id obj2 = [MessageForwarding new];
		
		/**
		 可以转发给多个对象，这里可以实现多继承
		 */
		[anInvocation invokeWithTarget:obj1];
		[anInvocation invokeWithTarget:obj2];
	}
}


@end
