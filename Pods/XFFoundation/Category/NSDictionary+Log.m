//
//  NSDictionary+Log.m
//  XFFoundation
//
//  Created by xiaoniu on 2018/10/12.
//  Copyright © 2018年 wangxuefeng. All rights reserved.
//

#import "NSDictionary+Log.h"

@implementation NSDictionary (Log)

- (NSString *)descriptionWithLocale:(id)locale {
    NSArray *allKeys = [self allKeys];
    
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"{\t\n "];
    
    for (NSString *key in allKeys) {
        id value = self[key];
        
        [str appendFormat:@"\t \"%@\" = %@,\n",key, value];
    }
    
    [str appendString:@"}"];
    
    return str;
}

@end
