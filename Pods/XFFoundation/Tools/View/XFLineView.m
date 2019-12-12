#import "XFLineView.h"

#define SINGLE_LINE_WIDTH (1 / [UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET ((1 / [UIScreen mainScreen].scale) / 2)

@implementation XFLineView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        // Initialization code
    }
    return self;
}

+ (NSNumber *)styleForName:(NSString *)name {
    if (name == nil) {
        return @(XFLineStyle_Normal);
    }
    if ([name isEqual:kXFLineStyle_Dash]) {
        return @(XFLineStyle_Dash);
    }
    return @(XFLineStyle_Normal);
}

- (id)init {
    self = [super init];
    
    if (self) {
        _lineStyle = @(XFLineStyle_Normal);
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (!self.lineColor) {
        self.lineColor = [UIColor colorWithRed:0.886 green:0.886 blue:0.886 alpha:1.00];
    }
    
    CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
    CGContextSetShouldAntialias(context, NO);
    // CGContextSetRGBFillColor(context, 0.0, 0.0, 1.0, 1.0);
    
    if ([_lineStyle intValue] == XFLineStyle_Dash) {
        CGFloat dash[] = {1.0, 1.0};
        CGContextSetLineDash(context, 0.0, dash, 2);
    }
    CGFloat width = [_lineWidth floatValue];
    CGFloat pixelAdjustOffset = 0;
    if (width < 1.1) {
        // 这是要画1像素线
        width = SINGLE_LINE_WIDTH;
        if (((int)(width * [UIScreen mainScreen].scale) + 1) % 2 == 0) {
            pixelAdjustOffset = SINGLE_LINE_ADJUST_OFFSET;
        }
    }
    CGContextSetLineWidth(context, width);
    CGPoint pt1, pt2;
    
    if (_lineDirection == XFLineDirection_Line) {
        if (self.bounds.size.height > self.bounds.size.width) {
            //竖线：
            pt1 = CGPointMake(self.bounds.size.width / 2 - pixelAdjustOffset, [self.margin1 floatValue]);
            pt2 = CGPointMake(self.bounds.size.width / 2 - pixelAdjustOffset,
                              self.bounds.size.height - [self.margin2 floatValue]);
        } else {
            //横线：
            
            if (self.isBottomLine) {
                pt1 = CGPointMake([self.margin1 floatValue], self.bounds.size.height - pixelAdjustOffset);
                pt2 = CGPointMake(self.bounds.size.width - [self.margin2 floatValue],
                                  self.bounds.size.height - pixelAdjustOffset);
                
            } else {
                pt1 =
                CGPointMake([self.margin1 floatValue], self.bounds.size.height / 2 - pixelAdjustOffset);
                pt2 = CGPointMake(self.bounds.size.width - [self.margin2 floatValue],
                                  self.bounds.size.height / 2 - pixelAdjustOffset);
            }
        }
    } else if (_lineDirection == XFLineDirection_LeftTop2RightBottom) {
        //斜线
        pt1 = CGPointMake([self.margin1 floatValue], [self.margin1 floatValue]);
        pt2 = CGPointMake(self.bounds.size.width - [self.margin2 floatValue],
                          self.bounds.size.height - [self.margin2 floatValue]);
    }
    CGContextMoveToPoint(context, pt1.x, pt1.y);
    CGContextAddLineToPoint(context, pt2.x, pt2.y);
    
    CGContextStrokePath(context);
}

@end
