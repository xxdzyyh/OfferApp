//
//  XFNOTipView.m
//  CTQProject
//
//  Created by wangxuefeng on 16/9/5.
//  Copyright © 2016年 code. All rights reserved.
//

#import "XFNOTipView.h"


@implementation XFNOTipView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
       self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    self.backgroundColor = [UIColor clearColor];
}

- (void)drawRect:(CGRect)rect {    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    float w = CGRectGetWidth(rect);
    float h = CGRectGetHeight(rect);
    
    // 画圆
    CGFloat radius = MIN(w, h)/2;
    
    CGContextSetRGBFillColor(context, 1, 0, 0, 1);
    CGContextAddArc(context, w/2, h/2, radius, 0, 2*M_PI, 0);
    CGContextDrawPath(context, kCGPathFill);
    
    // 绘制title
    UIFont *font = [UIFont systemFontOfSize:8];
    UIColor *color = [UIColor whiteColor];
    CGSize size = [_number boundingRectWithSize:CGSizeZero
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:font}
                                     context:nil].size;
    CGPoint origin = CGPointMake(w/2-size.width/2, h/2-size.height/2);
    
    [_number drawAtPoint:origin
          withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color}];
}

- (void)setNumber:(NSString *)number {
    if (![_number isEqualToString:number]) {
    
        [self willChangeValueForKey:@"number"];
        _number = number;
        [self didChangeValueForKey:@"number"];
        
        [self setNeedsDisplay];
    }
}

@end
