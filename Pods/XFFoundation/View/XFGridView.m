//
//  XFGridView.m
//  DevUIView
//
//  Created by wangxuefeng on 16/9/12.
//  Copyright © 2016年 wangxuefeng. All rights reserved.
//

#import "XFGridView.h"

@implementation XFGridView

- (void)drawRect:(CGRect)rect {
    float w = CGRectGetWidth(rect);
    float h = CGRectGetHeight(rect);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 1/[UIScreen mainScreen].scale);
    
    CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
    
    // 画垂直线
    for (int i=0; i<self.numberOfLinesAtX; i++) {
        CGContextBeginPath(context);
        
        CGContextMoveToPoint(context, i*w/self.numberOfLinesAtX, 0);
        CGContextAddLineToPoint(context, i*w/self.numberOfLinesAtX,h);
        
        CGContextStrokePath(context);
    }
    
    CGContextMoveToPoint(context, 0, 0);
    
    // 画水平线
    for (int j=0; j<self.numberOfLinesAtY; j++) {
        CGContextBeginPath(context);
        
        CGContextMoveToPoint(context, 0, j*h/self.numberOfLinesAtY);
        CGContextAddLineToPoint(context, w, j*h/self.numberOfLinesAtY);
        
        CGContextStrokePath(context);
    }
}

#pragma mark - setter & getter

@end
