//
//  XFLineHelper.m
//  CTQProject
//
//  Created by wangxuefeng on 16/5/27.
//  Copyright © 2016年 code. All rights reserved.
//

#import "XFLineHelper.h"
#import "XFLineView.h"

#define XFLineHeight 1

#define kXFSeperatorColor [UIColor colorWithRed:0.800 green:0.800 blue:0.800 alpha:1.00]

@implementation XFLineHelper

+ (void)delTopLine:(UIView *)view {
    UIView *v = [view viewWithTag:54321];
    
    if ([v isKindOfClass:[XFLineView class]] && 54321 == v.tag) {
        [v removeFromSuperview];
    }
}

+ (void)delBottomLine:(UIView *)view {
    UIView *v = [view viewWithTag:12345];
    
    if ([v isKindOfClass:[XFLineView class]] && 12345 == v.tag) {
        [v removeFromSuperview];
    }
}

+ (void)delTopAndBottomLine:(UIView *)view {
    [self delTopLine:view];
    [self delBottomLine:view];
}

+ (void)add15LeftBottomLineToView:(UIView *)view {
    [self delBottomLine:view];
    
    XFLineView *v =
    [[XFLineView alloc] initWithFrame:CGRectMake(0, view.frame.size.height - XFLineHeight,
                                                 view.frame.size.width, XFLineHeight)];
    v.lineWidth = @(XFLineHeight);
    v.lineColor = kXFSeperatorColor;
    v.tag = 12345;
    v.margin1 = @(15);
    v.margin2 = @(0);
    v.isBottomLine = YES;
    v.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [view addSubview:v];
}

+ (void)add15BottomLineToView:(UIView *)view {
    [self delBottomLine:view];
    
    XFLineView *v =
    [[XFLineView alloc] initWithFrame:CGRectMake(0, view.frame.size.height - XFLineHeight,
                                                 view.frame.size.width, XFLineHeight)];
    v.lineWidth = @(XFLineHeight);
    v.lineColor = kXFSeperatorColor;
    v.tag = 12345;
    v.margin1 = @(15);
    v.margin2 = @(15);
    v.isBottomLine = YES;
    v.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [view addSubview:v];
}

//移除底部细线
+ (void)removeBottomLineToView:(UIView *)view {
    [self delBottomLine:view];
}
//移除顶部细线
+ (void)removeTopLineToView:(UIView *)view {
    [self delTopLine:view];
}

//在底部增加一条细线。用于head section
+ (void)addBottomLineToView:(UIView *)view offsetLeft:(CGFloat)x offsetRight:(CGFloat)y {
    [self addBottomLineToView:view offsetLeft:x offsetRight:y color:kXFSeperatorColor];
}

//在底部增加一条细线。用于head section
+ (void)addBottomLineToView:(UIView *)view
                 offsetLeft:(CGFloat)x
                offsetRight:(CGFloat)y
                      color:(UIColor *)color {
    [self delBottomLine:view];
    
    XFLineView *v =
    [[XFLineView alloc] initWithFrame:CGRectMake(0, view.frame.size.height - XFLineHeight,
                                                  view.frame.size.width, XFLineHeight)];
    v.lineWidth = @(XFLineHeight);
    v.lineColor = color;
    v.tag = 12345;
    v.margin1 = @(x);
    v.margin2 = @(y);
    v.isBottomLine = YES;
    v.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [view addSubview:v];
}

//在顶部增加一条细线。用于head section
+ (void)addTopLineToView:(UIView *)view offsetLeft:(CGFloat)x offsetRight:(CGFloat)y {
    [self addTopLineToView:view offsetLeft:x offsetRight:y color:kXFSeperatorColor];
}

//在顶部增加一条细线。用于head section
+ (void)addTopLineToView:(UIView *)view
              offsetLeft:(CGFloat)x
             offsetRight:(CGFloat)y
                   color:(UIColor *)color {
    [self delTopLine:view];
    XFLineView *v =
    [[XFLineView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, XFLineHeight)];
    v.lineWidth = @(XFLineHeight);
    v.lineColor = color;
    v.tag = 54321;
    v.margin1 = @(x);
    v.margin2 = @(y);
    v.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    [view addSubview:v];
}

//在底部增加一条细线。用于head section
+ (void)addBottomLineToView:(UIView *)view {
    [self addBottomLineToView:view offsetLeft:0 offsetRight:0];
}

//在顶部增加一条细线。用于head section
+ (void)addTopLineToView:(UIView *)view {
    [self addTopLineToView:view offsetLeft:0 offsetRight:0];
}


/**
 在左侧增加一条细线。
 */
+ (void)addLeftLineInView:(UIView *)view {
    [self addLeftLineInView:view offsetLeft:0 offsetRight:0 color:kXFSeperatorColor];
}


/**
 删除左侧细线

 @param view <#view description#>
 */
+ (void)delLeftLine:(UIView *)view {
    UIView *v = [view viewWithTag:99998];
    
    if ([v isKindOfClass:[XFLineView class]] && 99998 == v.tag) {
        [v removeFromSuperview];
    }
}

/**
 在左侧增加一条细线

 @param view  添加到那个view上
 @param x     <#x description#>
 @param y     <#y description#>
 @param color <#color description#>
 */
+ (void)addLeftLineInView:(UIView *)view offsetLeft:(CGFloat)x offsetRight:(CGFloat)y color:(UIColor *)color {
    [self delLeftLine:view];
    
    XFLineView *v = [[XFLineView alloc] initWithFrame:CGRectMake(0, 0, 1, view.frame.size.height)];
    
    v.lineWidth = @(1);
    v.lineColor = color;
    v.tag = 99998;
    v.margin1 = @(x);
    v.margin2 = @(y);
    v.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [view addSubview:v];
}

/*!  * @brief 屏幕比例，默认是按320*480 为1倍 */
+ (CGFloat)sceneScale {
    return [UIScreen mainScreen].bounds.size.width / 320;
}

@end
