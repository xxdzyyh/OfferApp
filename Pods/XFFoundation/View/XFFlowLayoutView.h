//
//  XFFlowLayoutView.h
//  CTQProject
//
//  Created by wangxuefeng on 16/10/9.
//  Copyright © 2016年 code. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 简化版的UICollectionView,加在XFFlowLayoutView上的view会自动换行
 */
@interface XFFlowLayoutView : UIView

/**
 设置添加view的内边距，也就是四周留白的区域
 */
@property (assign, nonatomic) UIEdgeInsets padding;

/**
 行间距
 */
@property (assign, nonatomic) CGFloat lineSpacing;

/**
 元素之间horizontal spacing
 */
@property (assign, nonatomic) CGFloat interitemSpacing;

/**
 一行最大的宽度，用来确定何时换行
 */
@property (assign, nonatomic) CGFloat preferredMaxLayoutWidth;


/**
 是否为单行，默认为NO
 */
@property (assign, nonatomic) BOOL singleLine;

/**
 包含的元素和self.subviews相同，不可直接操作
 */
@property (strong, nonatomic, nullable, readonly) NSMutableArray *views;

/**
 在最后面添加view

 @param view 被添加的view
 */
- (void)addView:(nonnull UIView *)view;

/**
 在指定位置插入

 @param view  被添加的view
 @param index 插入的index
 */
- (void)insertView:(nonnull UIView *)view atIndex:(NSInteger)index;


/**
 一次添加多个view

 @param views 
 */
- (void)addViews:(nonnull NSArray *)views;

/**
 移除指定的view

 @param view 将要被移除的view
 */
- (void)removeView:(nonnull UIView *)view;


/**
 移除指定index的view

 @param index 将要被移除的view的index
 */
- (void)removeViewAtIndex:(NSUInteger)index;


/**
 情况所有的view
 */
- (void)removeAllViews;

@end
