//
//  MemoryObj.m
//  OfferApp
//
//  Created by xiaoniu on 2019/3/15.
//  Copyright © 2019 com.learn. All rights reserved.
//

#import "MemoryObj.h"

@implementation MemoryObj

+ (MemoryObj *)memoryObj {
    MemoryObj *memory = [[MemoryObj alloc] init];
    
    return memory;
}

- (void)dealloc {
    NSLog(@"MemoryObj dealloc");
}

@end
