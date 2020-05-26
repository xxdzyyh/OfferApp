//
//  NSStringVC.m
//  OfferApp
//
//  Created by wangxuefeng on 2020/5/22.
//  Copyright © 2020 com.learn. All rights reserved.
//

#import "NSStringVC.h"

@interface NSStringVC ()

@end

@implementation NSStringVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	// __NSCFConstantString
	// 以字面量形式生成的字符串都是字符串常量，和字符串的长度无关
	id a = @"123456789奥维尔微服私访就爱发发";
	id b = @"123";
	id c = [[NSString alloc] initWithString:a];
	
	// 0x10ac39068---__NSCFConstantString
	// 0x10ac38ae8---__NSCFConstantString
	// 0x10ac39068---__NSCFConstantString
	NSLog(@"%p---%@",a,[a class]);
	NSLog(@"%p---%@",b,[b class]);
	NSLog(@"%p---%@",c,[c class]);
	
	/** stringWithFormat
		1. 如果可以，系统会用 NSTaggedPointerString 来表示字符串
		2. 字符串达到一定长度，NSTaggedPointerString 无法表示，会生成真正的字符串
	 
		指针64位 1，2，... 64
		1：标识是否为NSTaggedPointer，1代表是
		2-4：紧随的三位表示NSTaggedPointer的具体类型（number？string）
	 
	 */
	id d = [NSString stringWithFormat:@"123"];
	
	// 0xc7287e8a4185f694---NSTaggedPointerString
	NSLog(@"%p---%@",d,[d class]);
	
	id e = [NSString stringWithFormat:@"123456789"];
	// 0xc6c261f8f9867e9e---NSTaggedPointerString
	NSLog(@"%p---%@",e,[e class]);
	
	
	
	id f = [NSString stringWithFormat:@"1234567890"];
	// 0x600000c9b760---__NSCFString
	NSLog(@"%p---%@",f,[f class]);
	
	// 0x600003535200---__NSCFString
	id g = [d stringByAppendingString:@"1234"];
	NSLog(@"%p---%@", g,[g class]);
}

@end
