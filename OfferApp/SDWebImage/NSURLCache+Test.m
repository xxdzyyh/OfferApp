//
//  NSURLCache+Test.m
//  OfferApp
//
//  Created by wangxuefeng on 2020/6/11.
//  Copyright © 2020 com.learn. All rights reserved.
//

#import "NSURLCache+Test.h"

#import <objc/runtime.h>

@implementation NSURLCache (Test)

+ (void)load {
	swizzleMethod(self, @selector(cachedResponseForRequest:), @selector(swizzlled_cachedResponseForRequest:));
	swizzleMethod(self, @selector(storeCachedResponse:forRequest:), @selector(swizzle_StoreCachedResponse:forRequest:));
	swizzleMethod(self, @selector(storeCachedResponse:forDataTask:), @selector(swizzle_StoreCachedResponse:forDataTask:));
}

- (NSCachedURLResponse *)swizzlled_cachedResponseForRequest:(NSURLRequest *)request {
	NSLog(@"%@",request);
	NSCachedURLResponse *res = [self swizzlled_cachedResponseForRequest:request];
	
	NSLog(@"%@---%@",request,res);
	
	return res;
}

void swizzleMethod(Class class,SEL originSel,SEL swizzledSelector) {
	Method originalMethod = class_getInstanceMethod(class, originSel);
	Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
	
	// 如果原方法不存在，先添加
	BOOL didAdd = class_addMethod(class, originSel, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
	
	if (didAdd) {
		// 添加方法是，添加的方法实现是交互后的结果，这个时候，将要交换的方法变成原实现即可
		class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
	} else {
		// 方法存在，没有加上
		method_exchangeImplementations(originalMethod, swizzledMethod);
	}
}

- (void)swizzle_StoreCachedResponse:(NSCachedURLResponse *)cachedResponse forRequest:(NSURLRequest *)request {
	[self swizzle_StoreCachedResponse:cachedResponse forRequest:request];
}

- (void)swizzle_StoreCachedResponse:(NSCachedURLResponse *)cachedResponse forDataTask:(NSURLSessionDataTask *)dataTask {
	[self swizzle_StoreCachedResponse:cachedResponse forDataTask:dataTask];
}

@end
