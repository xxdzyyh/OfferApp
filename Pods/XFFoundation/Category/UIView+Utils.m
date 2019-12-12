//
//  UIView+Utils.m
//  Borrowed from Three20
//
//  Copyright (c) 2013 iOS. No rights reserved.
//

#import "UIView+Utils.h"
#import <objc/runtime.h>
#import "XFMarco.h"

static char kDTActionHandlerTapBlockKey;
static char kDTActionHandlerTapGestureKey;
static char kDTActionHandlerLongPressBlockKey;
static char kDTActionHandlerLongPressGestureKey;

__unused static CGSize inchesSize3_5() {
    return CGSizeMake(320.0, 480.0);
}

__unused static CGSize inchesSize4_0() {
    return CGSizeMake(320.0, 568.0);
}

__unused static CGSize inchesSize4_7() {
    return CGSizeMake(375.0, 667.0);
}

__unused static CGSize inchesSize5_5() {
    return CGSizeMake(414.0, 736.0);
}

__unused static CGSize inchesSize5_8() {
    return CGSizeMake(375.0, 812.0);
}

__unused static CGSize inchesSize6_1() {
    return CGSizeMake(414.0, 896.0);
}

__unused static CGSize inchesSize6_5() {
    return CGSizeMake(414.0, 896.0);
}

CGFloat autoSizeScale() {
    return MIN(autoSizeScaleX(), autoSizeScaleY());
}

CGFloat autoSizeScaleX() {
    CGSize screenSize = UIScreen.mainScreen.bounds.size;
    CGFloat screenWidth = screenSize.width;
    return screenWidth / inchesSize4_7().width;
}

CGFloat autoSizeScaleY() {
    CGSize screenSize = UIScreen.mainScreen.bounds.size;
    CGFloat screenHeight = screenSize.height;
    
    if (CGSizeEqualToSize(screenSize, inchesSize3_5())) {
        screenHeight = inchesSize4_0().height;
    }
    else if (CGSizeEqualToSize(screenSize, inchesSize5_8())) {
        screenHeight = inchesSize4_7().height;
    }
    else if (CGSizeEqualToSize(screenSize, inchesSize6_1()) ||
             CGSizeEqualToSize(screenSize, inchesSize6_5())) {
        screenHeight = inchesSize5_5().height;
    }
    
    return screenHeight / inchesSize4_7().height;;
}

CGFloat scaleX(CGFloat value) {
    return value * autoSizeScaleX();
}

CGFloat scaleY(CGFloat value) {
    return value * autoSizeScaleY();
}

CGFloat CeilScaleX(CGFloat value) {
    return ceil(scaleX(value));
}

CGFloat CeilScaleY(CGFloat value) {
    return ceil(scaleY(value));
}

@implementation UIView (Utils)

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)screenX {
    CGFloat x = 0.0f;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
    }
    return x;
}

- (CGFloat)screenY {
    CGFloat y = 0.0f;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
    }
    return y;
}

- (CGFloat)screenViewX {
    CGFloat x = 0.0f;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            x -= scrollView.contentOffset.x;
        }
    }
    
    return x;
}

- (CGFloat)screenViewY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            y -= scrollView.contentOffset.y;
        }
    }
    return y;
}

- (CGRect)screenFrame {
    return CGRectMake(self.screenViewX, self.screenViewY, self.width, self.height);
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)orientationWidth {
    return UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)
    ? self.height : self.width;
}

- (CGFloat)orientationHeight {
    return UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)
    ? self.width : self.height;
}

- (UIView*)descendantOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls])
        return self;
    
    for (UIView* child in self.subviews) {
        UIView* it = [child descendantOrSelfWithClass:cls];
        if (it)
            return it;
    }
    
    return nil;
}

- (UIView*)ancestorOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls]) {
        return self;
        
    } else if (self.superview) {
        return [self.superview ancestorOrSelfWithClass:cls];
        
    } else {
        return nil;
    }
}

- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

- (CGPoint)offsetFromView:(UIView*)otherView {
    CGFloat x = 0.0f, y = 0.0f;
    for (UIView* view = self; view && view != otherView; view = view.superview) {
        x += view.left;
        y += view.top;
    }
    return CGPointMake(x, y);
}

- (void)setTapActionWithBlock:(void (^)(void))block {
	UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kDTActionHandlerTapGestureKey);
    
	if (!gesture) {
		gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__handleActionForTapGesture:)];
		[self addGestureRecognizer:gesture];
		objc_setAssociatedObject(self, &kDTActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
	}
    
	objc_setAssociatedObject(self, &kDTActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)__handleActionForTapGesture:(UITapGestureRecognizer *)gesture {
	if (gesture.state == UIGestureRecognizerStateRecognized) {
		void(^action)(void) = objc_getAssociatedObject(self, &kDTActionHandlerTapBlockKey);
        
		if (action) {
			action();
		}
	}
}

- (void)setLongPressActionWithBlock:(void (^)(void))block {
	UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, &kDTActionHandlerLongPressGestureKey);
    
	if (!gesture) {
		gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(__handleActionForLongPressGesture:)];
		[self addGestureRecognizer:gesture];
		objc_setAssociatedObject(self, &kDTActionHandlerLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
	}
    
	objc_setAssociatedObject(self, &kDTActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)__handleActionForLongPressGesture:(UITapGestureRecognizer *)gesture {
	if (gesture.state == UIGestureRecognizerStateBegan) {
		void(^action)(void) = objc_getAssociatedObject(self, &kDTActionHandlerLongPressBlockKey);
        
		if (action) {
			action();
		}
	}
}

- (void)addCornerRadius:(float)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.clipsToBounds = YES;
}

/**
 colors : 存放CGColor
 */
- (void)addHorizonGradientLayerWithColors:(NSArray *)colors {
    CAGradientLayer *layer = [CAGradientLayer layer];
    
    layer.colors = colors;
    layer.startPoint = CGPointMake(0, 1);
    layer.endPoint = CGPointMake(1, 1);
    layer.frame = self.bounds;
    layer.locations = @[@0,@1];
    
    [self.layer insertSublayer:layer atIndex:0];
}

- (void)removeGradientLayer {
    if ([self.layer.sublayers.firstObject isKindOfClass:[CAGradientLayer class]]) {
        [self.layer.sublayers.firstObject removeFromSuperlayer];
    }
}

- (void)addThemeHorizonGradientLayer {
	[self addHorizonGradientLayerWithColors:@[(id)UIColorFromRGB(0xF3B832).CGColor, (id)UIColorFromRGB(0xFE821D).CGColor,(id)UIColorFromRGB(0xF28466).CGColor]];
}

- (UIEdgeInsets)xf_safeAreaInsets {	
	if (@available(iOS 11.0, *)) {
		return [UIApplication sharedApplication].delegate.window.safeAreaInsets;
	} else {
		return UIEdgeInsetsMake(20, 0, 0, 0);
	}
}

- (UIViewController *)findViewController {
	id target = self;
	
	while (target) {
		target = ((UIResponder *)target).nextResponder;
		if ([target isKindOfClass:[UIViewController class]]) {
			break;
		}
	}
	return target;
}

@end
