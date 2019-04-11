//
//  XFFlowLayoutView.m
//
//  Created by wangxuefeng on 16/10/9.
//  Copyright © 2016年 code. All rights reserved.
//

#import "XFFlowLayoutView.h"

@interface XFFlowLayoutView()

@property (assign, nonatomic) BOOL didSetup;

@end

@implementation XFFlowLayoutView

- (CGSize)intrinsicContentSize {
    if (!self.views.count) {
        return CGSizeZero;
    }
    
    NSArray *subviews = self.subviews;
    UIView *previousView = nil;
    CGFloat topPadding = self.padding.top;
    CGFloat bottomPadding = self.padding.bottom;
    CGFloat leftPadding = self.padding.left;
    CGFloat rightPadding = self.padding.right;
    CGFloat itemSpacing = self.interitemSpacing;
    CGFloat lineSpacing = self.lineSpacing;
    CGFloat currentX = leftPadding;
    CGFloat intrinsicHeight = topPadding;
    CGFloat intrinsicWidth = leftPadding;
    
    if (!self.singleLine && self.preferredMaxLayoutWidth > 0) {
        NSInteger lineCount = 0;
        for (UIView *view in subviews) {
            CGSize size = view.frame.size;
            
            if (size.width == 0 || size.height == 0) {
                size = view.intrinsicContentSize;
            }
            
            if (previousView) {
                CGFloat width = size.width;
                currentX += itemSpacing;
                if (currentX + width + rightPadding <= self.preferredMaxLayoutWidth) {
                    currentX += size.width;
                } else {
                    lineCount ++;
                    currentX = leftPadding + size.width;
                    intrinsicHeight += size.height;
                }
            } else {
                lineCount ++;
                intrinsicHeight += size.height;
                currentX += size.width;
            }
            previousView = view;
            intrinsicWidth = MAX(intrinsicWidth, currentX + rightPadding);
        }
        
        intrinsicHeight += bottomPadding + lineSpacing * (lineCount - 1);
    } else {
        for (UIView *view in subviews) {
            CGSize size = view.frame.size;
            
            if (size.width == 0 || size.height == 0) {
                size = view.intrinsicContentSize;
            }
            
            intrinsicWidth += size.width;
        }
        intrinsicWidth += itemSpacing * (subviews.count - 1) + rightPadding;
        intrinsicHeight += ((UIView *)subviews.firstObject).intrinsicContentSize.height + bottomPadding;
    }
    
    return CGSizeMake(intrinsicWidth, intrinsicHeight);
}

- (void)layoutSubviews {
    if (!self.singleLine) {
        self.preferredMaxLayoutWidth = self.frame.size.width;
    }
    
    [super layoutSubviews];
    
    [self layoutTags];
}

- (void)layoutTags {
    if (self.didSetup || !self.views.count) {
        return;
    }
    
    NSArray *subviews = self.subviews;
    UIView *previousView = nil;
    CGFloat topPadding = self.padding.top;
    CGFloat leftPadding = self.padding.left;
    CGFloat rightPadding = self.padding.right;
    CGFloat itemSpacing = self.interitemSpacing;
    CGFloat lineSpacing = self.lineSpacing;
    CGFloat currentX = leftPadding;
    
    if (!self.singleLine && self.preferredMaxLayoutWidth > 0) {
        for (UIView *view in subviews) {
            CGSize size = view.frame.size;
            
            if (size.width == 0 || size.height == 0) {
                size = view.intrinsicContentSize;
            }
            
            if (previousView) {
                CGFloat width = size.width;
                currentX += itemSpacing;
                if (currentX + width + rightPadding <= self.preferredMaxLayoutWidth) {
                    view.frame = CGRectMake(currentX, CGRectGetMinY(previousView.frame), size.width, size.height);
                    currentX += size.width;
                } else {
                    CGFloat width = MIN(size.width, self.preferredMaxLayoutWidth - leftPadding - rightPadding);
                    view.frame = CGRectMake(leftPadding, CGRectGetMaxY(previousView.frame) + lineSpacing, width, size.height);
                    currentX = leftPadding + width;
                }
            } else {
                CGFloat width = MIN(size.width, self.preferredMaxLayoutWidth - leftPadding - rightPadding);
                view.frame = CGRectMake(leftPadding, topPadding, width, size.height);
                currentX += width;
            }
            
            previousView = view;
        }
    } else {
        for (UIView *view in subviews) {
            CGSize size = view.frame.size;
            
            if (size.width == 0 || size.height == 0) {
                size = view.intrinsicContentSize;
            }
            
            view.frame = CGRectMake(currentX, topPadding, size.width, size.height);
            currentX += size.width;
        }
    }
    
    self.didSetup = YES;
}

#pragma mark - Public

- (void)addView:(UIView *)view {
    if (view == nil) {
        return;
    }
    
    if (_views == nil) {
        _views = [NSMutableArray array];
    }
    
    [self addSubview:view];
    [self.views addObject:view];

    self.didSetup = NO;
    [self invalidateIntrinsicContentSize];
}

- (void)addViews:(NSArray *)views {
    if (_views == nil) {
        _views = [NSMutableArray array];
    }
    
    for (int i=0; i<views.count; i++) {
        UIView *view = [views objectAtIndex:i];
        
        [self addSubview:view];
        [self.views addObject:view];
    }
    
    self.didSetup = NO;
    [self invalidateIntrinsicContentSize];
}

- (void)insertView:(UIView *)view atIndex:(NSInteger)index {
    if (view == nil || index < 0) {
        return;
    }
    
    if (_views == nil) {
        _views = [NSMutableArray array];
    }
    
    if (index + 1 > self.views.count) {
        [self addView:view];
    } else {
        [self insertView:view atIndex:index];
        [self.views insertObject:view atIndex:index];
        self.didSetup = NO;
        [self invalidateIntrinsicContentSize];
    }
}

- (void)removeView:(UIView *)view {
    if (view == nil) {
        return;
    }
    
    [self.views removeObject:view];
    [view removeFromSuperview];
    
    self.didSetup = NO;
    [self invalidateIntrinsicContentSize];
}

- (void)removeViewAtIndex:(NSUInteger)index {
    if (index+1 > self.views.count) {
        return;
    }
    
    [self.views removeObjectAtIndex:index];
    if (self.subviews.count > index) {
        [self.subviews[index] removeFromSuperview];
    }
    
    self.didSetup = NO;
    [self invalidateIntrinsicContentSize];
}

- (void)removeAllViews {
    [self.views removeAllObjects];
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    self.didSetup = NO;
    [self invalidateIntrinsicContentSize];
}

#pragma mark - setter & getter

- (void)setPreferredMaxLayoutWidth: (CGFloat)preferredMaxLayoutWidth {
    if (preferredMaxLayoutWidth != _preferredMaxLayoutWidth) {
        _preferredMaxLayoutWidth = preferredMaxLayoutWidth;
        _didSetup = NO;
        [self invalidateIntrinsicContentSize];
    }
}

@end
