//
//  XFLabel.m
//  XFSocial
//
//  Created by wangxuefeng on 16/9/20.
//  Copyright © 2016年 wangxuefeng. All rights reserved.
//

#import "XFLabel.h"

@implementation XFLabel

- (void)drawTextInRect:(CGRect)rect {
    float w = CGRectGetWidth(rect) -self.paddings.left-self.paddings.right;
    float h = CGRectGetHeight(rect)-self.paddings.top -self.paddings.bottom;
    
    CGRect temp = CGRectMake(self.paddings.left, self.paddings.top, w, h);
    
    [super drawTextInRect:temp];
}

@end
