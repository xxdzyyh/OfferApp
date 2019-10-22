//
//  Son.m
//  OfferApp
//
//  Created by xiaoniu on 2018/10/12.
//  Copyright © 2018年 com.learn. All rights reserved.
//

#import "Son.h"
#import <objc/runtime.h>

@implementation Son

- (instancetype)init {
    self = [super init];
    if (self) {
        // super调用方法，方法的receiver还是self
        // super调用方法的时候直接从父类开始查找，class这个方法由NSObject实现
        // - (Class)class {
        //    return object_getClass(self); 
        // }
        // 因此返回的结果都是Son
        
        
        NSLog(@"%@",[self class]);
        NSLog(@"%@",[super class]);
        
        // fileName superclass自己有实现，因此返回Father
        // fileName self也实现了，输出Son
        
        NSLog(@"%@",[self fileName]);
        NSLog(@"%@",[super fileName]);
        
        [self test];

    }
    return self;
}

- (void)test {
    // Son
    // Father
    NSLog(@"test---%@",[super class]);
    NSLog(@"test---%@",[super superclass]);
}

- (NSString *)fileName {
    return @"Son";
}

@end
