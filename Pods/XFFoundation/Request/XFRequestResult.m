//
//  XFRequestResult.m
//  XFFoundation
//
//  Created by xiaoniu on 2019/1/14.
//  Copyright © 2019 wangxuefeng. All rights reserved.
//

#import "XFRequestResult.h"
#import <YYModel/YYModel.h>

@implementation XFRequestResult

- (instancetype)initWithObject:(id)obj {
    self = [super init];
    if (self) {
        _data = obj;
    }
    return self;
}

+ (XFRequestResult *)resultWithObject:(id)obj {
    return [[XFRequestResult alloc] initWithObject:obj];
}

@end
