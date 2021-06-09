//
//  XFRequestResult.h
//  XFFoundation
//
//  Created by xiaoniu on 2019/1/14.
//  Copyright © 2019 wangxuefeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFRequestResult : NSObject

@property (copy, nonatomic) NSString *msg;
@property (assign, nonatomic) BOOL success;
@property (strong, nonatomic) id data;

- (instancetype)initWithObject:(id)obj;
+ (XFRequestResult *)resultWithObject:(id)obj;

@end



