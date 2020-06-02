//
//  HashVSIsEqualVC.m
//  OfferApp
//
//  Created by wangxuefeng on 2020/5/28.
//  Copyright © 2020 com.learn. All rights reserved.
//

#import "HashVSIsEqualVC.h"

@interface HIObject : NSObject

@property (copy  , nonatomic) NSString *name;
@property (copy  , nonatomic) NSString *address;

@end

@implementation HIObject

//- (BOOL)isEqual:(id)object {
//	BOOL isEqual = [super isEqual:object];
//	NSLog(@"%s----%d",__func__,isEqual);
//	return isEqual;
//}

//- (NSUInteger)hash {
//	NSUInteger h = [super hash];
//	NSLog(@"%s----%lu",__func__,h);
//	return h;
//}

- (BOOL)isEqual:(id)object {
	if (object == self) {
		return YES;
	}
	
	if (![object isMemberOfClass:[HIObject class]]) {
		return NO;
	}
	
	HIObject *obj = object;
	
	BOOL isNameEqual = [self.name isEqual:obj.name];
	BOOL isAddressEqual = [self.address isEqual:obj.address];
	
	BOOL isEqual = isNameEqual && isAddressEqual;
	
	NSLog(@"%s----%d",__func__, isEqual);
	return isEqual;
}

- (NSUInteger)hash {
	/**
	 对关键属性的hash按位运算
	 */
	NSUInteger h = [self.name hash] ^ [self.address hash];
	NSLog(@"%s----%lu",__func__,h);
	return h;
}

@end

@interface HashVSIsEqualVC ()

@end

@implementation HashVSIsEqualVC

- (void)viewDidLoad {
	[super viewDidLoad];
	
	NSString *name = @"name";
	NSString *address = @"address";
	
	HIObject *obj1 = [[HIObject alloc] init];
	
	obj1.name = name;
	obj1.address = address;
	
	HIObject *obj2 = [[HIObject alloc] init];
	
	obj2.name = name;
	obj2.address = address;
	
	/**
		== 比较的是指针的地址
	 */
	NSLog(@"(obj1 == obj2) is %d",obj1 == obj2);
	
	NSLog(@"[obj1 isEqual:obj2] is %d",[obj1 isEqual:obj2]);
	
	NSMutableSet *set = [NSMutableSet set];
	
	/**
		添加元素时先进行hash比较,如果hash相同再进行isEqual比较，这样可以提高效率
		-[__NSSetM addObject:]
		-[HIObject hash:]
		-[HIObject isEqual:]
	 */
	[set addObject:obj1];
	[set addObject:obj2];
	
	NSLog(@"%@",set);
}

@end
