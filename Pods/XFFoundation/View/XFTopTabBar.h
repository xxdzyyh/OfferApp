//
//  XFTopTabBar.h
//  CTQProject
//
//  Created by wangxuefeng on 16/6/27.
//  Copyright © 2016年 code. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,XFTopBarIndicatorType) {
    XFTopBarIndicatorTypeDefault,
    XFTopBarIndicatorTypeLongLine,/*< 和item宽度一致 */
    XFTopBarIndicatorTypeShortLine/**< 短 */
};

@class XFTopTabBar;

@protocol XFTopTabBarDelegate <NSObject>

@optional

- (NSArray *)titlesForTopTabbar:(XFTopTabBar *)topTabBar;

- (NSArray *)attributeTitlesForTopbar:(XFTopTabBar *)topTabBar;

- (void)topTabbar:(XFTopTabBar *)topTabBar didSelectedItemAtIndex:(NSInteger)index;

@end

@interface XFTopTabBar : UIView

@property (strong, nonatomic) NSArray *titles;

/** 最后设置delegate,设置delegate时，会创建按钮 */
@property (weak  , nonatomic) id<XFTopTabBarDelegate> delegate;

/** 滑动指示器的宽，默认屏幕宽/titles.count */
@property (assign, nonatomic) float    indicatorWidth;

/** 滑动指示器的高度，默认2 */
@property (assign, nonatomic) float    indicatorHeight;

/** 滑动指示器的颜色 */
@property (strong, nonatomic) UIColor *indicatorColor;

/** 滑动指示器类型 */
@property (assign, nonatomic) XFTopBarIndicatorType indicatorType;

/** 未选中状态title的颜色 */
@property (strong, nonatomic) UIColor *normalStateColor;

/** 选中状态title的颜色 */
@property (strong, nonatomic) UIColor *selectedStateColor;

/** 未选中状态title的字体大小 */
@property (strong, nonatomic) UIFont  *normalStateFont;

/** 选中状态title的字体大小 */
@property (strong, nonatomic) UIFont  *selectedStateFont;

- (void)updateToSelectedStatus:(NSUInteger)index;

/**
 如果scrollView的页数和topbar的titles数目相同，直接设置scrollView.
 scrollView的滑动将和topbar进行联动，无需额外的设置，否则，不要设置scrollView
 */
@property (weak  , nonatomic) UIScrollView *scrollView;

/** title对应的按钮 */
@property (strong, nonatomic, readonly) NSArray *buttons;

// 当前选中的index
@property (assign, nonatomic) NSUInteger selectedIndex;

/**
 选中指定index的item，同时会触发delegate中的方法，如果关联了scrollView,还会滑动scrollView，
 注意scrollView的页数必须和topbar的titles数相同，否则，不要关联scrollView，直接在delegate方法中进行处理。
 
 @param index 选中的index，相当于直接点击了位于index的item
 */
- (void)setSelectedIndex:(NSUInteger)selectedIndex;

/**
 更新indicatorView的位置

 @param x indicatorView.center.x = x
 */
- (void)setIndicatorCenterX:(float)x;

@end
