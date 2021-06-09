//
//  UIButton+XNOHitEdgeInsets.m
//  XNOnline
//
//  Created by XN on 2017/5/9.
//  Copyright © 2017年 xiaoniu88. All rights reserved.
//

#import "UIButton+BFHitEdgeInsets.h"
@import ObjectiveC.runtime;

NS_ASSUME_NONNULL_BEGIN

@implementation UIButton (BFHitEdgeInsets)

- (void)setHitEdgeInsets:(UIEdgeInsets)hitEdgeInsets
{
    NSValue *value = [NSValue valueWithUIEdgeInsets:hitEdgeInsets];
    objc_setAssociatedObject(self, @selector(hitEdgeInsets), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)hitEdgeInsets
{
    NSValue *value = objc_getAssociatedObject(self, @selector(hitEdgeInsets));
    return value ? value.UIEdgeInsetsValue : UIEdgeInsetsZero;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event
{
    if (UIEdgeInsetsEqualToEdgeInsets(self.hitEdgeInsets, UIEdgeInsetsZero) ||
        !self.enabled ||
        self.hidden) {
        return [super pointInside:point withEvent:event];
    }
    CGRect hitFrame = UIEdgeInsetsInsetRect(self.bounds, self.hitEdgeInsets);
    return CGRectContainsPoint(hitFrame, point);
}

@end

NS_ASSUME_NONNULL_END
