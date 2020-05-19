//
//  CopyVC.m
//  OfferApp
//
//  Created by wangxuefeng on 2020/5/11.
//  Copyright © 2020 com.learn. All rights reserved.
//

#import "CopyVC.h"
#import "MemoryObj.h"

/**
 copy只是一个方法，具体的实现可以修改，只是要遵循一些通用的约定。
 
 [不可变对象 copy] = 指针引用
 
 浅拷贝：指针拷贝，新旧指针指向同一个地址
 深拷贝：内容拷贝，新旧指针指向不同的地址

 */

@interface CopyVC ()

/**
 - (void)setObj:(MemoryObj *)obj {
	 _obj = [obj copy];
 }
 */
@property (copy, nonatomic) MemoryObj *obj;

/**
 - (void)setObj2:(MemoryObj *)obj {
	 _obj2 = obj;
 }
 */
@property (strong, nonatomic) MemoryObj *obj2;


@end

@implementation CopyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self deepCopy];
}

- (void)crashIfCopy {
	/**
	  *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[MemoryObj copyWithZone:]: unrecognized selector sent to instance 0x6000014263e0'
	 * First throw call stack:
	 (
		 0   CoreFoundation                      0x00007fff23c4f02e __exceptionPreprocess + 350
		 1   libobjc.A.dylib                     0x00007fff50b97b20 objc_exception_throw + 48
		 2   CoreFoundation                      0x00007fff23c6ff94 -[NSObject(NSObject) doesNotRecognizeSelector:] + 132
		 3   CoreFoundation                      0x00007fff23c53dac ___forwarding___ + 1436
		 4   CoreFoundation                      0x00007fff23c55f38 _CF_forwarding_prep_0 + 120
		 5   libobjc.A.dylib                     0x00007fff50ba8c92 objc_setProperty_nonatomic_copy + 36
		 6   OfferApp                            0x0000000109dc2ce7 -[CopyVC setObj:] + 55
	 */
	
	// 因为使用的是copy关键字，所以setter里会调用 -[MemoryObj copy]
	// 进而调用 -[MemoryObj copyWithZone:]
	self.obj = [MemoryObj new];
	
	NSLog(@"%@",self.obj);
}
/**
 
 + (id)copyWithZone:(struct _NSZone *)zone {
	 return (id)self;
 }

 - (id)copy {
	 return [(id)self copyWithZone:nil];
 }

 + (id)mutableCopy {
	 return (id)self;
 }

 + (id)mutableCopyWithZone:(struct _NSZone *)zone {
	 return (id)self;
 }

 - (id)mutableCopy {
	 return [(id)self mutableCopyWithZone:nil];
 }

 */

- (void)shadowCopy {
	NSString *str = [NSString stringWithFormat:@"this is a really string"];
	
	// 对不可变对象进行 copy 是浅拷贝
	id str1 = [str copy];
	
	NSLog(@"%p",str);
	NSLog(@"%p",&str);
	NSLog(@"%p",str1);
	NSLog(@"%p",&str1);
	
	/**
	2020-05-14 21:33:49.476779+0800 OfferApp[4179:570742] 0x60000054e3d0
	2020-05-14 21:33:49.476987+0800 OfferApp[4179:570742] 0x7ffeea444ef8
	2020-05-14 21:33:49.477131+0800 OfferApp[4179:570742] 0x60000054e3d0
	2020-05-14 21:33:49.477271+0800 OfferApp[4179:570742] 0x7ffeea444ee8
	 
	 str 和 str1 指向同一个地址，是浅拷贝
	*/
}

- (void)deepCopy {
	NSMutableString *str = [NSMutableString stringWithFormat:@"this is a really string"];
	
	// 对可变对象进行 copy 是深拷贝
	id str1 = [str copy];
	
	NSLog(@"%p",str);
	NSLog(@"%p",&str);
	NSLog(@"%p",str1);
	NSLog(@"%p",&str1);
	/**
	 2020-05-14 21:51:02.668077+0800 OfferApp[4453:631085] 0x600000565c20
	 2020-05-14 21:51:02.668321+0800 OfferApp[4453:631085] 0x7ffeebca8f08
	 2020-05-14 21:51:02.668469+0800 OfferApp[4453:631085] 0x600000565c50
	 2020-05-14 21:51:02.668581+0800 OfferApp[4453:631085] 0x7ffeebca8f00
	 */
}

- (void)copyCollection {
	
}


@end
